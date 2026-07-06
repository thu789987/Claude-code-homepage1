-- Chạy toàn bộ file này trong Supabase Dashboard > SQL Editor > New query

create table if not exists page_content (
  page_id text primary key,
  content jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table page_content enable row level security;

-- Cho phép bất kỳ ai (kể cả chưa đăng nhập) đọc nội dung
create policy "Public read access"
  on page_content for select
  using (true);

-- Cho phép bất kỳ ai tạo dòng đầu tiên (upsert insert)
create policy "Public insert access"
  on page_content for insert
  with check (true);

-- Cho phép bất kỳ ai cập nhật nội dung đã lưu
create policy "Public update access"
  on page_content for update
  using (true)
  with check (true);

-- ===== Lịch sử thay đổi =====
-- Mỗi lần bấm "Lưu thay đổi", 1 bản snapshot được ghi thêm vào đây (không ghi đè)
-- để có thể xem lại / khôi phục các phiên bản trước.
create table if not exists page_content_history (
  id bigint generated always as identity primary key,
  page_id text not null,
  content jsonb not null,
  created_at timestamptz not null default now()
);

create index if not exists page_content_history_page_id_idx
  on page_content_history (page_id, created_at desc);

alter table page_content_history enable row level security;

-- Cho phép đọc lịch sử
create policy "Public read access"
  on page_content_history for select
  using (true);

-- Cho phép thêm bản ghi lịch sử mới (không cho update/delete để lịch sử không bị sửa lại)
create policy "Public insert access"
  on page_content_history for insert
  with check (true);
