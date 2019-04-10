import { Component } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { BookService } from '../../../services/book.service';
import { Router, ActivatedRoute } from '@angular/router';
import { AuthService } from '../../../services/auth.service';

@Component({
  selector: 'app-book',
  templateUrl: './book.component.html',
  styleUrls: ['./book.component.css']
})
export class BookComponent {
  book;
  user_profile: any;

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  constructor(private bookService: BookService,
              private router: Router,
              private http: HttpClient,
              private auth: AuthService,
              private activatedRoute: ActivatedRoute
  ) {
    if (this.auth.loggedIn) {
      this.http.get((`http://localhost:3000/api/v1/profile`), this.httpOptions)
        .subscribe(res => this.user_profile = res);
    }
    this.user_profile =  null;

    this.bookService.getBookById(this.activatedRoute.snapshot.params['id'])
      .then((resp) => {
        this.book = resp;
      });
  }

  deleteBook(bookId) {
    this.bookService.deleteBook(bookId).then((resp: any) => {
      console.log(resp);
      if (resp.status) {
        this.router.navigate(['/books']);
      } else {
        console.log(resp.message);
      }
    });
  }

  sameUser() {
    return this.auth.loggedIn && this.book.book.user_id === this.user_profile.user.id;
  }
}
