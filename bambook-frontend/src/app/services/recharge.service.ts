import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class RechargeService {

  apiUrl: string;

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  constructor(private http: HttpClient) {
    this.apiUrl = 'http://localhost:3000/api/v1/profile';
  }

  addRecharge(sum) {
    return this.http.post(`${this.apiUrl}/recharges`, {sum}, this.httpOptions);
  }
}
