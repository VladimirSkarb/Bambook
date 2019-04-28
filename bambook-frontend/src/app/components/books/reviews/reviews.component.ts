import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BookService } from '../../../services/book.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-reviews',
  templateUrl: './reviews.component.html',
  styleUrls: ['./reviews.component.css']
})
export class ReviewsComponent {
  reviews;
  book;

  constructor(private bookService: BookService, private http: HttpClient, private activatedRoute: ActivatedRoute) {
    this.bookService.getBookById(this.activatedRoute.snapshot.params['id'])
      .then((resp) => {
        this.book = resp;
      });

    http.get(`http://localhost:3000/api/v1/books/${this.activatedRoute.snapshot.params['id']}/reviews`).toPromise().then((resp) => {
      this.reviews = resp;
    });

  }
}
