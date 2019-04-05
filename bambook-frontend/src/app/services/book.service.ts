import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';


@Injectable({
  providedIn: 'root'
})
export class BookService {

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  }

  constructor(private http: HttpClient) { }

  addBook(book) {
    const fd = new FormData();
    fd.append('book[title]', book.book.title);
    fd.append('book[author]', book.book.author);
    fd.append('book[description]', book.book.description);
    fd.append('book[cover_photo]', book.book.cover_photo);
    fd.append('book[book_file]', book.book.book_file);

    return this.http.post('http://localhost:3000/api/v1/books', fd, this.httpOptions);
  }
}
