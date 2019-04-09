import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {JwtService} from '../jwt.service';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  user_profile: any;

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  constructor(private http: HttpClient,
              private jwtService: JwtService) {}

  public get loggedIn(): boolean {
    return localStorage.getItem('access_token') !==  null;
  }

  logout() {
    console.log('logout')
    this.jwtService.logout();
  }

  getUser(): any {
    if (this.loggedIn) {
      this.http.get((`http://localhost:3000/api/v1/profile`), this.httpOptions)
        .subscribe(res => this.user_profile = res);
      console.log(this.user_profile);
      return this.user_profile;
    }
    return null;
  }

}
