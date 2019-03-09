import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { BooksComponent } from './components/books/books.component';
import { HomeComponent } from './components/home/home.component';

const routes: Routes = [
  { path:  'auth', loadChildren:  './components/auth/auth.module#AuthModule' },
  { path: 'home', component: HomeComponent},
  { path: '', component: BooksComponent, pathMatch: 'full' },
  { path: 'books', component: BooksComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
