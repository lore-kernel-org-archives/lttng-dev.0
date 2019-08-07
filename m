From: Yiteng Guo <guoyiteng@gmail.com>
Subject: [RFC PATCH lttng-tools] Hugepages Shared Memory Support
 in LTTng
Date: Wed, 7 Aug 2019 10:44:28 -0400
Message-ID: <CAO+PNdHPpMAn4EoHv8wn2BtD=a4tsib_hadE6BxAPjyRhbUY6g__5285.57198574475$1565189095$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by lists.lttng.org (Postfix) with ESMTPS id 463Z6073q8z16cl
 for <lttng-dev@lists.lttng.org>; Wed,  7 Aug 2019 10:44:40 -0400 (EDT)
Received: by mail-wr1-x444.google.com with SMTP id n9so91776999wru.0
 for <lttng-dev@lists.lttng.org>; Wed, 07 Aug 2019 07:44:40 -0700 (PDT)
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
to show the viability and advantages of hugepages.

To use hugepages for the shared memory, we need to create a memory
mapped files on a hugetlbfs directory /dev/hugepages instead of
/dev/shm. See [1] for the instruction to mount a hugetlbfs virtual file
system.

This patch simply changes the location of the shm file and replaces
shm_open/shm_unlink with open/unlink. This patch could not work
independently. It should be used together with another patch in
lttng-ust [2]. See that patch for more hugepages information.

This patch is based on commit 4e328cceb6ff5fd6240c866b52b29234946c5c66.

[1] https://wiki.debian.org/Hugepages
[2] [RFC PATCH lttng-ust] Hugepages Shared Memory Support in LTTng

Signed-off-by: Yiteng Guo <guoyiteng@gmail.com>
---
 src/common/ust-consumer/ust-consumer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/common/ust-consumer/ust-consumer.c
b/src/common/ust-consumer/ust-consumer.c
index 94b761cb..aadb25c6 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -378,7 +378,8 @@ int create_posix_shm(void)
  char tmp_name[NAME_MAX];
  int shmfd, ret;

- ret = snprintf(tmp_name, NAME_MAX, "/ust-shm-consumer-%d", getpid());
+ // use HugePage dir.
+ ret = snprintf(tmp_name, NAME_MAX,
"/dev/hugepages/ust-shm-consumer-%d", getpid());
  if (ret < 0) {
  PERROR("snprintf");
  return -1;
@@ -390,12 +391,12 @@ int create_posix_shm(void)
  * pathname so that some OS implementations can keep it local to
  * the process (POSIX leaves this implementation-defined).
  */
- shmfd = shm_open(tmp_name, O_CREAT | O_EXCL | O_RDWR, 0700);
+ shmfd = open(tmp_name, O_CREAT | O_EXCL | O_RDWR, 0700);
  if (shmfd < 0) {
  PERROR("shm_open");
  goto error_shm_open;
  }
- ret = shm_unlink(tmp_name);
+ ret = unlink(tmp_name);
  if (ret < 0 && errno != ENOENT) {
  PERROR("shm_unlink");
  goto error_shm_release;
-- 
2.17.1
