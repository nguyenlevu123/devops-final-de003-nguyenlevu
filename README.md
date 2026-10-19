# DevOps Final – Đề 003: Quản lý công việc

Bộ mã nguồn khởi đầu cho bài thi **DevOps Fundamentals – Cuối kỳ**.
Ứng dụng hiển thị **danh sách công việc** lấy từ MySQL thông qua Spring Boot, trả về **dạng JSON** qua Nginx (reverse proxy).

## Kiến trúc

```
Trình duyệt ── http://<IP_máy_chủ>:<APP_PORT>
    ▼
[nginx]  nginx:1.27-alpine        GET /*  → app:8080
    ▼
[app]    Spring Boot 4 (JRE 21)   GET /api/tasks → mysql:3306
    ▼
[mysql]  mysql:8.0                volume mysql_data, KHÔNG public cổng mysql
```

## Cấu trúc thư mục

Đổi tên thư mục/repository thành `devops-final-de003-<họ-tên>` (ví dụ `devops-final-de003-nguyenvana`).
Dấu ★ là phần sinh viên phải làm.

```
devops-final-de003-nguyenvana/     ← Mã nguồn Spring Boot 4 (Java 21, Gradle) – CÓ SẴN
├── src/main/java/com/ptit/devops/task/   ← Controller, Entity, Repository
├── src/main/resources/application.properties
├── build.gradle                   ← Build ra file build/libs/app.jar
├── settings.gradle
├── Dockerfile                     ← ★ FILE KHUNG: tự hoàn chỉnh phần còn thiếu
├── .dockerignore                  ← CÓ SẴN
├── nginx/default.conf             ← ★ FILE KHUNG: tự đổi PORT (tránh trùng nhau)
├── database/init.sql              ← Bảng tasks + 8 bản ghi mẫu – CÓ SẴN
├── docker-compose.yml             ← ★ FILE KHUNG: mysql có sẵn, điền TODO 1–5
├── .github/workflows/ci-cd.yml    ← ★ FILE KHUNG: điền TODO 1–6
├── student.env                    ← ★ ĐIỀN THÔNG TIN SINH VIÊN
├── screenshots/                   ← ★ Ảnh minh chứng (Phần 5)
├── submission-content/            ← ★ Toàn bộ tệp minh chứng khi nộp bài
├── .gitignore                     ← CÓ SẴN
└── README.md
```

Phần **sinh viên phải làm** (xem đề thi):

| File | Việc cần làm |
|------|--------------|
| `student.env` | Điền thông tin sinh viên và thông số triển khai |
| `Dockerfile` | **Hoàn chỉnh**: multi-stage build, stage `build` (Gradle + JDK 21) và stage runtime (JRE 21) |
| `docker-compose.yml` | **Điền các TODO 1–5** (service `mysql` đã có sẵn) |
| `.github/workflows/ci-cd.yml` | **Điền các TODO 1–6** của pipeline build → push image → deploy |
| `screenshots/` | `01-actions.png`, `02-ghcr.png`, `03-compose-ps.png`, `04-website.png` |

## API của ứng dụng

| Method | Đường dẫn | Mô tả |
|--------|-----------|-------|
| GET | `/api/tasks` | Danh sách công việc |

## Biến môi trường mà ứng dụng cần

| Biến | Ý nghĩa |
|------|---------|
| `DB_HOST`, `DB_PORT` | Địa chỉ MySQL (mặc định `mysql`, `3306`) |
| `DB_NAME`, `DB_USER`, `DB_PASSWORD` | Database và tài khoản kết nối |
| `APP_VERSION` | Phiên bản (truyền vào lúc build image, ví dụ commit SHA) |

## Chạy thử (khi đã hoàn thiện Dockerfile và docker-compose.yml)

```bash
docker compose --env-file student.env up -d --build
docker compose --env-file student.env ps
curl http://localhost:<APP_PORT>/api/tasks
docker compose --env-file student.env down
```



devops-final-de003-nguyenlevu






sudo adduser test1

# 4. Tạo sẵn thư mục app để nhận code
mkdir -p ~/app
exit

GIAI ĐOẠN 2: TẠO REPO & CÀI SECRETS (TRÊN TRÌNH DUYỆT)
Vào [github.com/new](https://github.com/new) tạo repo mới (chế độ Public).
Vào Settings ➔ Secrets and variables ➔ Actions ➔ New repository secret.
Thêm đủ 11 biến Secret sau:
Tên Secret	Giá trị (Value) điền vào
SERVER_HOST103.77.208.221
SERVER_USERnguyenlevu123
SERVER_PORT22
SERVER_SSH_KEY *(Mở PowerShell máy tính chạy lệnh: Get-Content "$HOME\.ssh\id_ed25519" | Set-Clipboard
DOCKER_USER levux1
DOCKER_PAT(Token Docker Hub của bạn có quyền Read & Write)
DB_NAMEtaskdb (hoặc tên database trong file sql của đề thi)
DB_USER root
DB_PASS hoatien20
DB_PORT 1822
DB_URL jdbc:mysql://db:3306/taskdb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true

GIAI ĐOẠN 3: SỬA PORT TRONG CODE & PUSH (TRÊN MÁY TÍNH)
1. Mở file docker-compose.yml trong source code đề thi, chỉnh port của 2 service:

YAML
db:
ports:
- "127.0.0.1:${DB_PORT:-1822}:3306"
app:
ports:
- "1825:8083"
2. Mở PowerShell tại thư mục code và dán lệnh để đẩy lên GitHub:

PowerShell
git init
git branch -M main
git remote remove origin 2>$null
git remote add origin https://github.com/nguyenlevu123/<ten-repo-vua-tao>.git
git add .
git commit -m "ci: deploy via github actions"
git push -u origin main --force



