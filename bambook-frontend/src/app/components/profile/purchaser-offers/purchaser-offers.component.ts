import { Component } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Component({
  selector: 'purchaser-offers',
  templateUrl: './purchaser-offers.component.html',
  styleUrls: ['./purchaser-offers.component.css']
})

export class PurchaserOffersComponent {

  avaliable_offers;

  apiUrl = 'http://localhost:3000/api/v1/profile';

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  constructor(private http: HttpClient) {
    http.get(`${this.apiUrl}/offers`, this.httpOptions).toPromise().then((resp) => {
      this.avaliable_offers = resp;
    });
  }

}
