import { Component, OnInit } from '@angular/core';
import {BookService} from '../../../services/book.service';
import {ActivatedRoute, Router} from '@angular/router';
import {AuthService} from '../../../services/auth.service';
import {HttpClient, HttpHeaders} from '@angular/common/http';

@Component({
  selector: 'app-update-book',
  templateUrl: './update-book.component.html',
  styleUrls: ['./update-book.component.css']
})
export class UpdateBookComponent implements OnInit {
  book;
  id;
  user_profile: any;
  title: string;
  author: string;
  description: string;

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  cover_photo: File;
  book_file: File;

  message: string;

  constructor(private bookService: BookService,
              private http: HttpClient,
              private router: Router,
              private activatedRoute: ActivatedRoute,
              private auth: AuthService) {
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

  ngOnInit() {
    this.id = this.activatedRoute.snapshot.params['id'];
    this.bookService.getBookById(this.id).then((resp) => {
      this.book = resp;
    });
  }

  onPhotoSelected(event) {
    this.cover_photo = event.target.files[0];
  }

  onFileSelected(event) {
    this.book_file = event.target.files[0];
  }

  updateBook(bookId) {

    if ((this.title && this.title !== '') &&
      (this.author && this.author !== '') &&
      (this.cover_photo && this.cover_photo != null) &&
      (this.description && this.description != null)) {

      const book = {
        book:
          {
            title: this.title,
            author: this.author,
            description: this.description,
            cover_photo: this.cover_photo,
            book_file: this.book_file
          }
      };
      this.bookService.updateBook(bookId, book).subscribe((resp: any) => {
        console.log(resp.book);
        if (resp.book) {
          this.router.navigate(['/books/' + resp.book.id]);
          console.log('The book was created');
        } else {
          console.log(resp.message);
        }
      });
    } else {
      this.message = 'Please fill in all fields';
    }
  }
  sameUser() {
    return this.auth.loggedIn && this.book.book.user_id === this.user_profile.user.id;
  }

}
