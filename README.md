# BBCIncorp LinkedIn Guideline — site có thể chỉnh sửa

Trang guideline gốc, cộng thêm, khi bấm **"Bật chế độ chỉnh sửa"**:
- **Sửa chữ** — click vào bất kỳ đoạn text nào (heading, paragraph, list, bảng, callout...) và gõ trực tiếp.
- **Đổi màu** — chuột phải vào ô màu trong bảng palette (mục II) hoặc vào một callout (khối có icon 🎨 ở góc) để mở bảng chọn màu. Với ô palette, mã hex hiển thị cũng tự cập nhật theo màu mới.
- **Đổi / thêm ảnh bằng link** — click vào bất kỳ ảnh nào trong Phụ lục (thư viện Canva) để dán link ảnh mới; click vào ô placeholder trống (⊕) để dán link ảnh và biến nó thành ảnh thật. Link bạn dán vừa dùng để hiển thị ảnh, vừa là nơi card dẫn tới khi người xem click vào (ngoài chế độ chỉnh sửa) — không cần cập nhật link riêng.
- **Thêm / xoá ô ảnh** — mỗi lưới ảnh trong Phụ lục có nút **"+ Thêm ảnh"** ở cuối để thêm ô mới (dán link ngay hoặc để trống thêm sau); mỗi ô có nút **✕** ở góc để xoá hẳn ô đó (có xác nhận trước khi xoá).
- Nút **"Lưu thay đổi"** — lưu toàn bộ (chữ, màu, ảnh) vào Supabase (Postgres).
- Nút **"🕘 Lịch sử"** — xem lại các lần lưu trước đó (mỗi lần bấm Lưu tạo 1 bản ghi lịch sử, không ghi đè), và **Khôi phục** về một phiên bản cũ bất kỳ (áp dụng ngay cho mọi người, đồng thời tự tạo thêm 1 bản ghi lịch sử mới cho lần khôi phục đó).
- Nút **"📥 Xuất dữ liệu"** — tải về máy 1 file JSON chứa toàn bộ nội dung hiện tại, kèm danh sách tóm tắt dễ đọc tất cả link ảnh đã thêm (tuyến nào, ô thứ mấy, link gì). Dùng để tự sao lưu — nếu sau này cần reset dữ liệu trên Supabase (ví dụ khi đổi cấu trúc lưu trữ), bạn vẫn có file này làm bằng chứng/tham khảo để nhập lại thủ công.
- Ai mở lại trang (kể cả người khác) sau khi reload sẽ thấy đúng bản đã lưu gần nhất.
- Không cần đăng nhập — bất kỳ ai có link đều sửa được (theo lựa chọn bạn đã chọn). Xem mục "Lưu ý bảo mật" bên dưới.

**Giới hạn hiện tại:** đổi màu chỉ áp dụng cho ô màu trong bảng palette và callout (nền là 1 màu đơn). Các khối gradient nhiều màu (thanh tiêu đề 7 tuyến nội dung, các mockup demo M1–M7) chưa hỗ trợ đổi màu trực tiếp vì chúng dùng gradient nhiều điểm màu — báo lại nếu bạn cần mở rộng thêm phần này.

## Bước 1 — Tạo Supabase project (miễn phí)

1. Vào https://supabase.com → Sign up / Sign in → **New project**.
2. Đặt tên bất kỳ, chọn region gần Việt Nam nhất (Singapore), tạo password cho database (không cần nhớ, không dùng ở bước sau).
3. Đợi project khởi tạo xong (~1-2 phút).

## Bước 2 — Tạo bảng dữ liệu

1. Vào project vừa tạo → menu bên trái **SQL Editor** → **New query**.
2. Copy toàn bộ nội dung file [`supabase-schema.sql`](supabase-schema.sql) vào, bấm **Run**.
3. Kiểm tra: menu **Table Editor** phải thấy 2 bảng `page_content` (bản hiện tại) và `page_content_history` (lịch sử các lần lưu).

> Nếu bạn đã tạo bảng `page_content` từ trước và giờ chỉ muốn thêm tính năng lịch sử, chỉ cần chạy lại toàn bộ file `supabase-schema.sql` — các câu lệnh `create table if not exists` sẽ bỏ qua bảng đã có sẵn và chỉ tạo thêm `page_content_history`.

## Bước 3 — Lấy API keys

1. Vào **Project Settings** (icon bánh răng) → **API**.
2. Copy 2 giá trị:
   - **Project URL** (dạng `https://xxxxx.supabase.co`)
   - **anon public** key (chuỗi dài bắt đầu `eyJ...`)
3. Mở file [`config.js`](config.js), dán vào:
   ```js
   window.SUPABASE_URL = 'https://xxxxx.supabase.co';
   window.SUPABASE_ANON_KEY = 'eyJ...';
   ```

## Bước 4 — Deploy

### Cách A: Vercel (khuyên dùng, kéo-thả)
1. Vào https://vercel.com → Add New → Project → **Deploy without Git** (hoặc kéo thư mục `linkedin-guideline-site` vào).
2. Framework Preset chọn **Other** (không cần build command, đây là static site thuần).
3. Deploy — xong sẽ có link dạng `https://ten-du-an.vercel.app`.

### Cách B: Netlify (kéo-thả còn nhanh hơn)
1. Vào https://app.netlify.com/drop
2. Kéo thả cả thư mục `linkedin-guideline-site` vào — Netlify tự deploy ngay, ra link luôn.

> Chỉ cần đúng 2 file `index.html`, `config.js` cùng nằm trong thư mục deploy — không cần build step gì cả.
> (`server.js` chỉ dùng để test local, không cần deploy file này, có deploy theo cũng không sao vì host tĩnh không chạy nó.)

## Bước 5 — Test

1. Mở link đã deploy.
2. Bấm **"Bật chế độ chỉnh sửa"** (góc dưới phải):
   - Click vào một đoạn text và sửa chữ.
   - Chuột phải vào một ô màu (mục II) hoặc một callout, chọn màu mới.
   - Click vào một ảnh trong Phụ lục, dán link ảnh mới.
3. Bấm **"Lưu thay đổi"**.
4. Mở lại link đó ở trình duyệt ẩn danh (hoặc máy khác) → phải thấy đúng nội dung, màu, ảnh vừa sửa.
5. Bấm **"🕘 Lịch sử"** → phải thấy bản vừa lưu; sửa thêm 1 lần nữa rồi Lưu, mở lại Lịch sử phải thấy 2 bản; bấm **Khôi phục** ở bản cũ hơn để kiểm tra nội dung quay lại đúng bản đó.

## Lưu ý bảo mật

Vì bạn chọn "ai có link cũng sửa được, không cần đăng nhập", nên **anon key** trong `config.js` cho phép public ghi dữ liệu — bất kỳ ai biết link web đều có thể sửa nội dung. Phù hợp cho tài liệu nội bộ chia sẻ trong team nhỏ, nhưng:
- Không dùng cách này cho trang public rộng rãi hoặc chứa thông tin nhạy cảm.
- Nếu sau này muốn giới hạn quyền sửa (cần mã/đăng nhập), báo lại — có thể thêm Supabase Auth mà không cần đổi cấu trúc hiện tại.

## Cách hoạt động (tóm tắt kỹ thuật)

- Khi trang load, script tự gán `data-eid` cho các phần tử có thể sửa (text, ô màu, cả lưới ảnh) theo đúng thứ tự xuất hiện trong HTML, và gắn thêm class đánh dấu loại (`et-text`, `et-color`, `et-grid`) để quyết định hành vi tương ứng.
- Mỗi lưới ảnh (`et-grid`) được quản lý như 1 danh sách card — thêm/xoá/đổi link đều thao tác trực tiếp trên danh sách này, không theo dõi từng ảnh riêng lẻ. Khi lưu, toàn bộ danh sách card hiện tại của lưới (link ảnh + link click) được gom thành 1 mảng JSON gắn với đúng lưới đó.
- Script gọi Supabase để lấy `content` (JSON dạng `{eid: {html, style}}` cho text/màu, `{eid: {cards: [...]}}` cho lưới ảnh) và ghi đè vào đúng phần tử tương ứng.
- Khi bấm Lưu, script gom trạng thái hiện tại của toàn bộ phần tử `[data-eid]` (nội dung chữ, `style` inline cho màu, `src` cho ảnh) thành 1 object JSON, `upsert` vào 1 dòng duy nhất trong bảng `page_content` (bản "hiện tại", không tạo dòng mới mỗi lần lưu), **đồng thời `insert` thêm 1 dòng mới vào bảng `page_content_history`** (bảng này chỉ cho phép đọc + thêm, không cho sửa/xoá, nên lịch sử không bị viết đè).
- Bấm **"🕘 Lịch sử"** sẽ tải tối đa 50 bản ghi gần nhất từ `page_content_history` (mới nhất trước) để hiển thị. Bấm **Khôi phục** ở một bản cũ sẽ: áp dụng nội dung đó lên trang hiện tại, `upsert` nó thành bản "hiện tại" trong `page_content`, và ghi thêm 1 dòng lịch sử mới — nên hành động khôi phục cũng được lưu vết như một lần lưu bình thường.
