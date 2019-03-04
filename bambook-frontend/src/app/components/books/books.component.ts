import { Component, OnInit } from '@angular/core';
import { HttpClient} from '@angular/common/http';

@Component({
  selector: 'app-books',
  templateUrl: './books.component.html',
  styleUrls: ['./books.component.css']
})
export class BooksComponent {
  // title = 'List of books from localhost:3000/books.json ';
  title = 'Books'
  books;

  constructor(private http: HttpClient) {
    http.get('http://localhost:3000/api/v1/books.json')
      .subscribe(res => this.books = res);
  }
}