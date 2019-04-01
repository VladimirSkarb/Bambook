import { Component } from '@angular/core';
import { HttpClient} from '@angular/common/http';

// import { JwtService } from './jwt.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  // title = 'List of books from localhost:3000/books.json ';
  // books;
  //
  // constructor(//private jwtService: JwtService,
  //             private http: HttpClient) {
  //   http.get('http://localhost:3000/api/v1/books.json')
  //     .subscribe(res => this.books = res);
  // }

  // logout() {
  //   console.log('logout')
  //   this.jwtService.logout()
  // }
  //
  // public get loggedIn(): boolean{
  //   return localStorage.getItem('access_token') !==  null;
  // }

}
