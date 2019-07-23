From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: HugePages shared memory support in LLTng
Date: Tue, 23 Jul 2019 11:07:44 -0400
Message-ID: <20190723150744.GC803__39038.11638463$1563894482$gmane$org@joraj-alpa>
References: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
 <20190715143302.GA2017@joraj-alpa>
 <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
 <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ@mail.gmail.com>
 <20190722192308.GA803@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45tMKY5bwrz18RC
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jul 2019 11:07:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id F14CA26AA06
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jul 2019 11:07:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190722192308.GA803@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yiteng Guo <guoyiteng@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi Yiteng,

On Mon, Jul 22, 2019 at 03:23:08PM -0400, Jonathan Rajotte-Julien wrote:
> Hi Yiteng,
> 
> On Mon, Jul 22, 2019 at 02:44:09PM -0400, Yiteng Guo wrote:
> > Hi Jonathan,
> > 
> > I spent these days on this problem and finally figured it out. Here
> > are patches I've written.
> 
> Sorry for that, I had other stuff ongoing.
> 
> I had a brief discussion about this with Mathieu Desnoyers.
> 
> Mathieu mentioned that the page faults you are seeing might be related to
> qemu/kvm usage of KSM [1]. I did not have time to play around with it and see if
> this indeed have an effect. You might be better off trying it since you are
> already all setup. Might want to disable it and retry your experiment (if only
> doing this on a vm).

Disregard all of this for now. I think we misunderstood the first email and got
too far too fast.

I modified lttng-ust to use MAP_POPULATE and based on the result from the page_fault
perf counter it seems to achieve what you are looking for.

See attached patch. Let me know if this help.

Cheers.
-- 
Jonathan Rajotte-Julien
EfficiOS

--TB36FDmn/VVEgNH/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Use-MAP_POPULATE-to-reduce-pagefault.patch"

From 2b065e5988067291e3367f413571248f4551acb2 Mon Sep 17 00:00:00 2001
From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Date: Mon, 22 Jul 2019 17:37:43 -0400
Subject: [PATCH lttng-ust] Use MAP_POPULATE to reduce pagefault

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 libringbuffer/shm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libringbuffer/shm.c b/libringbuffer/shm.c
index 10b3bcef..489322e6 100644
--- a/libringbuffer/shm.c
+++ b/libringbuffer/shm.c
@@ -154,7 +154,7 @@ struct shm_object *_shm_object_table_alloc_shm(struct shm_object_table *table,
 
 	/* memory_map: mmap */
 	memory_map = mmap(NULL, memory_map_size, PROT_READ | PROT_WRITE,
-			  MAP_SHARED, shmfd, 0);
+			  MAP_SHARED | MAP_POPULATE, shmfd, 0);
 	if (memory_map == MAP_FAILED) {
 		PERROR("mmap");
 		goto error_mmap;
@@ -341,7 +341,7 @@ struct shm_object *shm_object_table_append_shm(struct shm_object_table *table,
 
 	/* memory_map: mmap */
 	memory_map = mmap(NULL, memory_map_size, PROT_READ | PROT_WRITE,
-			  MAP_SHARED, shm_fd, 0);
+			  MAP_SHARED | MAP_POPULATE, shm_fd, 0);
 	if (memory_map == MAP_FAILED) {
 		PERROR("mmap");
 		goto error_mmap;
-- 
2.17.1


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--TB36FDmn/VVEgNH/--
