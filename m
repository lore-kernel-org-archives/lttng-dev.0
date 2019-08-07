From: Yiteng Guo <guoyiteng@gmail.com>
Subject: [RFC PATCH lttng-ust] Hugepages Shared Memory Support
 in LTTng
Date: Wed, 7 Aug 2019 10:42:47 -0400
Message-ID: <CAO+PNdGjfYUKyAQeEHTis-0WbU3zaU8j4yVwXnAYuATqsGxruw__37660.1649260678$1565188996$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by lists.lttng.org (Postfix) with ESMTPS id 463Z441Lt7z16bw
 for <lttng-dev@lists.lttng.org>; Wed,  7 Aug 2019 10:43:00 -0400 (EDT)
Received: by mail-wm1-x344.google.com with SMTP id v19so288967wmj.5
 for <lttng-dev@lists.lttng.org>; Wed, 07 Aug 2019 07:43:00 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch is not expected to be integrated into LTTng. Its purpose is
to demonstrate the viability and advantages of hugepages.

Hugepages shared memory can also be accessed by mmap. The only
problem we need to take care of is the alignment. The size of shared
memory on hugepages should be a multiple of hugepage size (2MB in most
cases). This patch modified zero_file function to achieve this purpose.

Without hugepages support, if a large buffer (subbuf-size=2M) was
created, a noticeably larger overhead was got (1200ns larger than other) for
every ~130 tracepoints after running a certain number of tracepoints.
This overhead was due to a page fault. The number was matched up (130 *
32 bytes = 4160 bytes, which was approximately the size of a normal
page). I also used lttng perf page fault context to verify this theory.
This patch, together with another patch in lttng-tools [1], could be
used to solve this problem.

To test this patch, a simple benchmark program is needed. The benchmark
program has a spinning while loop for 10000 iterations and calls
tracepoint(...) in each iteration. With this patch, you won't observe
periodic larger overheads or increasing page faults if the context is
added.

This patch is based on commit: 3f6807bfb5f8e87d09251d3b284d9d586741186b.

[1] [RFC PATCH lttng-tools] Hugepages support in LTTng

Signed-off-by: Yiteng Guo <guoyiteng@gmail.com>
---
 libringbuffer/ring_buffer_backend.c |  5 ++-
 libringbuffer/shm.c                 | 70 ++++++++++++++++-------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/libringbuffer/ring_buffer_backend.c
b/libringbuffer/ring_buffer_backend.c
index 2dea1db5..4d1c1beb 100644
--- a/libringbuffer/ring_buffer_backend.c
+++ b/libringbuffer/ring_buffer_backend.c
@@ -31,6 +31,8 @@
 #include "smp.h"
 #include "shm.h"

+#define TWO_MB 2UL*1024*1024
+
 /**
  * lib_ring_buffer_backend_allocate - allocate a channel buffer
  * @config: ring buffer instance configuration
@@ -335,7 +337,7 @@ int channel_backend_init(struct channel_backend *chanb,
  num_subbuf_alloc = num_subbuf + 1;
  shmsize += offset_align(shmsize, __alignof__(struct
lttng_ust_lib_ring_buffer_backend_pages_shmp));
  shmsize += sizeof(struct
lttng_ust_lib_ring_buffer_backend_pages_shmp) * num_subbuf_alloc;
- shmsize += offset_align(shmsize, page_size);
+ shmsize += offset_align(shmsize, TWO_MB);
  shmsize += subbuf_size * num_subbuf_alloc;
  shmsize += offset_align(shmsize, __alignof__(struct
lttng_ust_lib_ring_buffer_backend_pages));
  shmsize += sizeof(struct lttng_ust_lib_ring_buffer_backend_pages) *
num_subbuf_alloc;
@@ -343,6 +345,7 @@ int channel_backend_init(struct channel_backend *chanb,
  shmsize += sizeof(struct
lttng_ust_lib_ring_buffer_backend_subbuffer) * num_subbuf;
  shmsize += offset_align(shmsize, __alignof__(struct
lttng_ust_lib_ring_buffer_backend_counts));
  shmsize += sizeof(struct lttng_ust_lib_ring_buffer_backend_counts) *
num_subbuf;
+ shmsize += offset_align(shmsize, TWO_MB);

  if (config->alloc == RING_BUFFER_ALLOC_PER_CPU) {
  struct lttng_ust_lib_ring_buffer *buf;
diff --git a/libringbuffer/shm.c b/libringbuffer/shm.c
index 10b3bcef..fe0909b9 100644
--- a/libringbuffer/shm.c
+++ b/libringbuffer/shm.c
@@ -41,6 +41,8 @@
 #include <helper.h>
 #include <ust-fd.h>

+#define TWO_MB 2UL * 1024 * 1024
+
 /*
  * Ensure we have the required amount of space available by writing 0
  * into the entire buffer. Not doing so can trigger SIGBUS when going
@@ -49,34 +51,43 @@
 static
 int zero_file(int fd, size_t len)
 {
- ssize_t retlen;
- size_t written = 0;
- char *zeropage;
- long pagelen;
  int ret;

- pagelen = sysconf(_SC_PAGESIZE);
- if (pagelen < 0)
- return (int) pagelen;
- zeropage = calloc(pagelen, 1);
- if (!zeropage)
- return -ENOMEM;
-
- while (len > written) {
- do {
- retlen = write(fd, zeropage,
- min_t(size_t, pagelen, len - written));
- } while (retlen == -1UL && errno == EINTR);
- if (retlen < 0) {
- ret = (int) retlen;
- goto error;
- }
- written += retlen;
+ struct stat fdStat;
+
+ // get the size of fd.
+ ret = fstat(fd, &fdStat);
+
+ if (ret < 0) {
+ PERROR("zero_file fstat");
+ return -1;
  }
- ret = 0;
-error:
- free(zeropage);
- return ret;
+
+ // truncate to a new size.
+ ret = ftruncate(fd, len);
+
+ if (ret < 0) {
+ PERROR("zero_file ftruncate");
+ return -1;
+ }
+
+ void* addr = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED |
MAP_HUGETLB, fd, 0);
+
+ if (addr < 0) {
+ PERROR("zero_file mmap");
+ return -1;
+ }
+
+ // zero out the old memory region.
+ memset(addr, 0, fdStat.st_size);
+
+ ret = munmap(addr, len);
+ if (ret) {
+ PERROR("umnmap");
+ assert(0);
+ }
+
+ return 0;
 }

 struct shm_object_table *shm_object_table_create(size_t max_nb_obj)
@@ -135,11 +146,7 @@ struct shm_object
*_shm_object_table_alloc_shm(struct shm_object_table *table,
  PERROR("zero_file");
  goto error_zero_file;
  }
- ret = ftruncate(shmfd, memory_map_size);
- if (ret) {
- PERROR("ftruncate");
- goto error_ftruncate;
- }
+
  /*
  * Also ensure the file metadata is synced with the storage by using
  * fsync(2).
@@ -154,7 +161,7 @@ struct shm_object
*_shm_object_table_alloc_shm(struct shm_object_table *table,

  /* memory_map: mmap */
  memory_map = mmap(NULL, memory_map_size, PROT_READ | PROT_WRITE,
-   MAP_SHARED, shmfd, 0);
+   MAP_SHARED | MAP_HUGETLB, shmfd, 0);
  if (memory_map == MAP_FAILED) {
  PERROR("mmap");
  goto error_mmap;
@@ -169,7 +176,6 @@ struct shm_object
*_shm_object_table_alloc_shm(struct shm_object_table *table,

 error_mmap:
 error_fsync:
-error_ftruncate:
 error_zero_file:
 error_fcntl:
  for (i = 0; i < 2; i++) {
-- 
2.17.1
