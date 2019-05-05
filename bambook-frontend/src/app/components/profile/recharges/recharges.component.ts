import { Component } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Component({
  selector: 'recharges',
  templateUrl: './recharges.component.html',
  styleUrls: ['./recharges.component.css']
})
export class RechargesComponent {
  recharges;

  apiUrl = 'http://localhost:3000/api/v1/profile';

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  constructor(private http: HttpClient) {

    http.get(`${this.apiUrl}/recharges`, this.httpOptions).toPromise().then((resp) => {
      this.recharges = resp;
    });
  }

}
