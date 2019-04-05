import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {JwtService} from "../jwt.service";

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  // user: any;

  constructor(private http: HttpClient,
              private jwtService: JwtService) { }

  public get loggedIn(): boolean {
    return localStorage.getItem('access_token') !==  null;
  }

  logout() {
    console.log('logout')
    this.jwtService.logout();
  }
}
