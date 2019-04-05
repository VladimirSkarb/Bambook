import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class BookService {
  apiUrl: string;

  constructor(
    private http: HttpClient
  ) {
    this.apiUrl = 'http://localhost:3000/api/v1/books';
  }

  getBookById(bookId): Promise<Object> {
    return this.http.get(`${this.apiUrl}/${bookId}`).toPromise().then((resp) => {
      let book = resp;
      return book;
    });
  }
}
