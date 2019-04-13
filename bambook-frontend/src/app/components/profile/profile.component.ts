import { Component } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent {
  user_data;
  recharges;
  avaliable_offers;

  apiUrl = 'http://localhost:3000/api/v1/profile';

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  constructor(private http: HttpClient) {
    http.get(`${this.apiUrl}`, this.httpOptions).toPromise().then((resp) => {
      this.user_data = resp;
    });

    http.get(`${this.apiUrl}/recharges`, this.httpOptions).toPromise().then((resp) => {
      this.recharges = resp;
    });

    http.get(`${this.apiUrl}/offers`, this.httpOptions).toPromise().then((resp) => {
      this.avaliable_offers = resp;
    });
  }

}
