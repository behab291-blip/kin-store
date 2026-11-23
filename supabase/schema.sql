-- KIN store database. Replace admin@example.com with the email used for your admin login.
create extension if not exists pgcrypto;
create table if not exists public.products (
 id uuid primary key default gen_random_uuid(),
 name text not null,
 description text,
 price numeric(10,2) not null check(price>=0),
 category text not null check(category in ('hoodie','tee')),
 image_url text,
 colors text[] not null default '{}',
 sizes text[] not null default '{}',
 stock integer not null default 0,
 active boolean not null default true,
 created_at timestamptz not null default now()
);
create table if not exists public.orders (
 id uuid primary key default gen_random_uuid(),
 customer_name text not null,
 phone text not null,
 address text not null,
 notes text,
 items jsonb not null,
 total numeric(10,2) not null,
 payment_method text not null default 'cash_on_delivery',
 status text not null default 'new',
 created_at timestamptz not null default now()
);
alter table public.products enable row level security;
alter table public.orders enable row level security;
create policy "Public can view active products" on public.products for select using (active=true or (auth.jwt()->>'email'='admin@example.com'));
create policy "Admin can insert products" on public.products for insert with check (auth.jwt()->>'email'='admin@example.com');
create policy "Admin can update products" on public.products for update using (auth.jwt()->>'email'='admin@example.com') with check (auth.jwt()->>'email'='admin@example.com');
create policy "Admin can delete products" on public.products for delete using (auth.jwt()->>'email'='admin@example.com');
create policy "Customers can place orders" on public.orders for insert with check (status='new' and payment_method='cash_on_delivery');
create policy "Admin can read orders" on public.orders for select using (auth.jwt()->>'email'='admin@example.com');
create policy "Admin can update orders" on public.orders for update using (auth.jwt()->>'email'='admin@example.com') with check (auth.jwt()->>'email'='admin@example.com');
-- Create a PUBLIC storage bucket named products in Storage, then add policies:
create policy "Public can view product images" on storage.objects for select using (bucket_id='products');
create policy "Admin can upload product images" on storage.objects for insert with check (bucket_id='products' and auth.jwt()->>'email'='admin@example.com');
create policy "Admin can update product images" on storage.objects for update using (bucket_id='products' and auth.jwt()->>'email'='admin@example.com');
