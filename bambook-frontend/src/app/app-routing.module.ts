import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { BooksComponent } from './components/books/books.component';
import { AddBookComponent } from './components/books/add-book/add-book.component';
import { BookComponent } from './components/books/book/book.component';
import { AddOfferComponent } from './components/offers/add-offer/add-offer.component';
import { OfferComponent } from './components/offers/offer/offer.component';
import { OffersComponent } from './components/offers/offers.component';

const routes: Routes = [
  { path:  'auth', loadChildren:  './components/auth/auth.module#AuthModule' },
  { path: 'books', component: BooksComponent},
  { path: 'books/add', component: AddBookComponent},
  { path: 'books/:id' , component: BookComponent },
  { path: 'offers/add', component: AddOfferComponent},
  { path: 'offers/:id' , component: OfferComponent },
  { path: 'offers', component: OffersComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
