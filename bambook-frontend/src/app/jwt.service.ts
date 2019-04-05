import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class JwtService {
  constructor(private httpClient: HttpClient) { }

  login(user) {
    return this.httpClient.post<{access_token:  string}>('http://localhost:3000/api/v1/users/login', user).pipe(tap(res => {
      localStorage.setItem('access_token', res.access_token);
    }))
  }

  register(user) {
    return this.httpClient.post<{access_token: string}>('http://localhost:3000/api/v1/users', user).pipe(tap(res => {
      // this.login(user)
    }))
  }

  logout() {
    localStorage.removeItem('access_token');
  }
}
