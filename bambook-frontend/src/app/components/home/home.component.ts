import { Component, OnInit } from '@angular/core';
import { HttpClient} from '@angular/common/http';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  // title = 'List of books from localhost:3000/books.json ';
  title = 'Books'
  books;

  constructor(private http: HttpClient) {
    http.get('http://localhost:3000/api/v1/books.json')
      .subscribe(res => this.books = res);
  }
}
