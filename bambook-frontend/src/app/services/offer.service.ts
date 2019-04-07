import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class OfferService {

  apiUrl: string;

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  constructor(private http: HttpClient) {
    this.apiUrl = 'http://localhost:3000/api/v1/offers';
  }

  addOffer(offer) {
    return this.http.post('http://localhost:3000/api/v1/offers', offer, this.httpOptions);
  }

  getOfferById(offerId): Promise<Object> {
    return this.http.get(`${this.apiUrl}/${offerId}`).toPromise().then((resp) => {
      let offer = resp;
      return offer;
    });
  }

  subscribeToOffer(offerId) {
    let offer_id = {
      offer_id: offerId
    };
    return this.http.post((`${this.apiUrl}/${offerId}/subscriptions`), offer_id, this.httpOptions);
  }
}
