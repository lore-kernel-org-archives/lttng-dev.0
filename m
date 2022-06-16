Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEBBCCA47A
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jun 2022 08:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655366986;
	bh=HsDVC8xNfM3T6qT1/pg83xGzr8prWJiSnZnRl80yBcQ=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GNzKQsR9kJ172GDcEJMBzv8TAoWOePeVYeJ8YTKmcxm3dp5c/s1556xeBaIone6sH
	 VGYWt4a5QLi+Q8zTskM+Kz80Xdh0UwP25Fev1x4OBo16tbt77zevsvwiYri5F5jeds
	 OQ0KAAvWSYMcDQ3bvRzM4g0P3cf1fpPqKRA+fsh+rJ39i0tz44iw/krK0NAPRGM3HZ
	 JngLcWsJdKUp1oXHVO9NLgOkntiRZP47a3FcD/JD20W4g7/dOjuz8BVaV9h4QlBjHQ
	 wUizaoCQWpg1mhY+TWhIi2qri5BocTp1OsqfzSpB9V49VtEPsxKTYQKSQU8fRlSW69
	 rxP4bgME9/SOw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LNvwT6rm8z96x;
	Thu, 16 Jun 2022 04:09:45 -0400 (EDT)
Received: from smtpbguseast1.qq.com. (smtpbguseast1.qq.com [54.204.34.129])
 by lists.lttng.org (Postfix) with ESMTPS id 4LNvwR3p6kz9bd
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jun 2022 04:09:43 -0400 (EDT)
X-QQ-mid: bizesmtp83t1655366957tyhe7vs3
Received: from localhost.localdomain ( [113.87.195.227])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Jun 2022 16:09:15 +0800 (CST)
X-QQ-SSF: 01400000008000B0G000B00A0000000
X-QQ-FEAT: eTtJes0duVvTNOt8x0nb4YRqRcBIQH0GMZgFBMilPK/MDNok3KCgR1HCkb9lj
 +VsONcYd5uyAXfJCH0c4x0k9ecGobhDeYH50xsDTM2gz9iqddaghKhhSINnpI6zTRSkM1Bq
 MdxTFVRYC1BCPctXQJ3YyNU8G8lNAYtj50XCNQ90goqBjH9z0b4PA2jOqFV59oc8giP3MTk
 m0zKsZS2nn6JHboVmVaa17yy1vU+BRkb5X/rugJdyWN7WPzQ6N7rhT1mIgZu3Oj0wfJhJrk
 5eXc06F/TFcBGatZG3581fd5TajNbnu7YqJobZR1mg+J4QPrBhRZI325+OMgwFy4R1AiY1G
 JFy6XTrYed8965MuxYkqpZbSD85Z7ysHmvVx2ZC
X-QQ-GoodBg: 2
Date: Thu, 16 Jun 2022 04:09:12 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20220616080912.GA246781@localhost.localdomain>+A9F2DC87F5C41B48
References: <20220614035533.GA174967@localhost.localdomain>
 <765519142.60031.1655221996546.JavaMail.zimbra@efficios.com>
 <20220615034900.GA187807@localhost.localdomain>
 <396090936.61897.1655302558168.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <396090936.61897.1655302558168.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:szsandstone.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
Subject: Re: [lttng-dev] urcu workqueue thread uses 99% of cpu while
 workqueue is empty
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Minlan Wang via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Minlan Wang <wangminlan@szsandstone.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, Mathieu,
I tried to write a simple program to reproduce this issue, but failed.
The environment we used to produce this issue is a storage cluster.
It has 3 nodes, each with an NVME and several SATA disks, urcu is part of the
storage cluster software.
The storage software is pretty big, 3+ GB in size. I guess it's hard for you to
build a environment like ours.

Besides, I made some change into workqueue.c to debug this issue today, here's
the patch i used for debuging:

From 18f3fea1436e0c999b346b998b7153150b92e62f Mon Sep 17 00:00:00 2001
From: wangminlan <wangminlan@szsandstone.com>
Date: Wed, 15 Jun 2022 14:28:53 +0800
Subject: [PATCH] <urcu> debug workqueue->futex

---
 .../userspace-rcu-0.12.1/src/workqueue.c           | 49 ++++++++++++++++++----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/ceph/thirdpart/ascache/thirdparty/userspace-rcu-0.12.1/src/workqueue.c b/ceph/thirdpart/ascache/thirdparty/userspace-rcu-0.12.1/src/workqueue.c
index 59eb21d..eed1e21 100644
--- a/ceph/thirdpart/ascache/thirdparty/userspace-rcu-0.12.1/src/workqueue.c
+++ b/ceph/thirdpart/ascache/thirdparty/userspace-rcu-0.12.1/src/workqueue.c
@@ -132,12 +132,21 @@ static int set_thread_cpu_affinity(struct urcu_workqueue *workqueue)
 
 static void futex_wait(int32_t *futex)
 {
+	int ret;
+	int err;
 	/* Read condition before read futex */
 	cmm_smp_mb();
-	if (uatomic_read(futex) != -1)
+	if (uatomic_read(futex) != -1) {
+		fprintf(stderr, "%lu: wq %p: %s futex != -1, don't wait\n",
+			pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex), __func__);
+
 		return;
-	while (futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0)) {
-		switch (errno) {
+	}
+	while ((ret = futex_async(futex, FUTEX_WAIT, -1, NULL, NULL, 0))) {
+		err = errno;
+		fprintf(stderr, "%lu: wq %p: %s failed, errno %d\n",
+			pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex), __func__, err);
+		switch (err) {
 		case EWOULDBLOCK:
 			/* Value already changed. */
 			return;
@@ -146,17 +155,35 @@ static void futex_wait(int32_t *futex)
 			break;	/* Get out of switch. */
 		default:
 			/* Unexpected error. */
-			urcu_die(errno);
+			urcu_die(err);
 		}
 	}
+
+	fprintf(stderr, "%lu: wq %p: %s wait return %d\n",
+		pthread_self(), caa_container_of(futex, struct urcu_workqueue, futex), __func__, ret);
+
 }
 
 static void futex_wake_up(int32_t *futex)
 {
 	/* Write to condition before reading/writing futex */
+	int32_t old;
+
 	cmm_smp_mb();
-	if (caa_unlikely(uatomic_read(futex) == -1)) {
-		uatomic_set(futex, 0);
+	old = uatomic_read(futex);
+	if (caa_unlikely(old == -1)) {
+		old = uatomic_xchg(futex, 0);
+		if (old == -1) {
+			fprintf(stderr, "%lu: wq %p, wakeup succeed: old %d\n",
+				pthread_self(),
+				caa_container_of(futex, struct urcu_workqueue, futex),
+				old);
+		} else {
+			fprintf(stderr, "%lu: wq %p, wakeup failed: old %d\n",
+				pthread_self(),
+				caa_container_of(futex, struct urcu_workqueue, futex),
+				old);
+		}
 		if (futex_async(futex, FUTEX_WAKE, 1,
 				NULL, NULL, 0) < 0)
 			urcu_die(errno);
@@ -237,8 +264,16 @@ static void *workqueue_thread(void *arg)
 		if (!rt) {
 			if (cds_wfcq_empty(&workqueue->cbs_head,
 					&workqueue->cbs_tail)) {
+				int32_t new;
 				futex_wait(&workqueue->futex);
-				uatomic_dec(&workqueue->futex);
+				new = uatomic_add_return(&workqueue->futex, -1);
+				if (new == -1) {
+					fprintf(stderr, "%lu: wq %p dec succeed: old %d, new %d\n",
+						pthread_self(), workqueue, new + 1, new);
+				} else {
+					fprintf(stderr, "%lu: wq %p dec failed: old %d\n",
+						pthread_self(), workqueue, new + 1);
+				}
 				/*
 				 * Decrement futex before reading
 				 * urcu_work list.
-- 
1.8.3.1

And the instresting log began from here:
---
...
   2097 140196498532096: wq 0x55f69a99ea00, wakeup succeed: old -1	/* enqueue op set futex: -1 -> 0 */
   2098 140196272453376: wq 0x55f69a99ea00: futex_wait wait return 0	/* workqueue_thread wait success */
   2099 140196272453376: wq 0x55f69a99ea00 dec failed: old -1		/* workqueue_thread got futex == -1 ? */
   2100 140196272453376: wq 0x55f69a99ea00: futex_wait futex != -1, don't wait
   2101 140196272453376: wq 0x55f69a99ea00 dec failed: old -2
...
---
In line 2099, how did workqueue_thread got futex as -1? This is wierd.

I put the patch i used to debug, and the complete log of the reproduce into the
attachment, may this helps.

Thanks,
Minlan

--yrj/dFKFPuw6o+aM
Content-Type: application/gzip
Content-Disposition: attachment; filename="debug.tar.gz"
Content-Transfer-Encoding: base64

H4sIAOrkqmIAA+2dbWxk11nHJ9uyjadpE5VXUSROgtLaa3t8z3nOnRdvNqQkaZs3Ekg2S1Wi
0Xjmjj3seMaZF7wLpKiKUEFVQShFqO0XpH5AwAeQKvGFfgGEVF4ENJSSlpK+8tJCKaW8pUDL
c++MX+as1+sEb/5j+3+UZ8f2M/ee3z333Gfuie9PbiQrw9Wl3HVtkbZSKU5fbSmOdr9utZz1
LnZx0VlbzEXWxlExZ+LrizVqw/6g1jMmt97erHVWr/6+a+WPaGtk5z89I4vDXn24mH2/uNnt
XXxymAyTxeZwkFwqbNQG9bWX3Ed2/uOrnv+i8/HW+bfe21zkIpE4Z6JDPM6rthN+/t/c664b
W25KM6lZL8UkqlcqlRXxxZVKpbxSsrHoxbhScUnRNc1D3Y55NNkwtmSiaDn7zzg9m/l0N8sm
HaH1Vqdd65g7dr6+q/8T/Vqn0R90O0mh3l2/M39PbZAsmwtJY8HY2Nw/7OhOnDPWL7vycixm
PipHUf7R4cqPJfXBsnn7I2967O63PmHuSGfonSabomZnit6ZzdF8fnFxMW8KhcLSsJ/0+hu1
erKYzuioYF3BLvV79aXtbQp1s9N+yviKmb+iLWb7s6bZaiemvqaHk/J6Z1od3f+g1e30Z+fn
FkxJgdrJ6PvFuXy+0Wo2zeLiamtgakv1ZGNtabDW6jU2ar3BUq1fr9XXkp2fXD4Y7Moh7Sjf
6jSSSyauJCvONgqFJGnYxFlj9Sr0Ph3BQ2PO6xAeHvddd5lFK27BOjOfviqz/kgv3UGrridk
YPrJoDpY6yW1RrW+MazWms1WpzW4PNsf9Ib1gUlnTnV7h+bM9pdzeZPf2s+Pd1sNk02m6mat
NZjV/YqrDsyZ7Gf6zp/Mz8+knfWSwdnxl0mvdzZvZpbOmB/Wvk2922m00rlgVpJmt5eYlGi0
T3NmSd9YX1+v9tc3qusrs3Nn84szraaZHdYG3fVWvZq+d3bUl7n1nB7wXNrJvm/IkGaaGz1l
aerBNpRnwdx2e3uoV+OT5vaNZXN7f9x/tsWCaXQ7bxyY9AB/tHPbQrr5zMZ45PpJuzmrU7pe
q1X1SAa1VifpVbvNUZ8LZs/BXBjtXjerVpvDTr1a1QOb10Od0WEa9jrpUW6upRfRaDfVWv9y
p761yzeff+zeH6leeNN9jy1kdD94/sEHt/6N5tLjW5yZ6W+29PPHzOrBdbqjY35KY7zXWe3H
nDMvfufj0dO96ubZvs8eaDRr2q2WgmwLc3vjeg1j1sNchrRrAFJoHdt6rZ+Yey88fP7Be37g
wYfvfmA5/WE6DR+vtXWC19opyeWtulUYTb6dU5JdT764oIV83sbxgsS7rqdrXge6oxXd/8Wz
aYdv0dHvDjWaZoS51VkjadaG7cE22flOcmlDC3rSSA+s28vep2d3JhuIRisZn9/siCd+OJde
YnrKTXraNXutM5RSm9Gh7jo/h356tIfRVH/qakXkYlIdbuxVR7KKcaHXGiRm0N27arQ6q0ub
+g593SkgWdHJdtZtN0aX2V4VJT20Yafdupi0L+9ZPc5l1WN8eW29QWvo1hhE2VnQPvTK2GP7
s+PCNNFP9u7t/eqAT25+qb62Orn7bBc7W4022u/kLph0SIcbpj+s1/Wzazkdhd1XYHiORz98
aSd6tK12MGJ9yiRtveQOzjgqEy8rYnqVpGO6Tyl84F6951rILsmZyXJo7tB/ssQV12NaLZyU
Fspm3hX9gi2GxWLn83T8ITw7+nGttzq3BXVrbzCuXaOp0+hXN5v1J6vJ+oZ+Tr9h1/1cfaVf
XdOdjDFnwpyOUntrjs1sXxCdZPPsaINdpesN4W1idonM7Mz5RlLf803ZrnWXuyZwrdGojorK
lVukny9bW6VHl225e1bvO2f0DrIezumF9IAmJs6VFWzXjEjfPK9nNv1iC2Riyl4b4GoT9iD9
bnc5OgNLZ0av5oy5J6n3kvVEb5VGRWyywm2/bXuGm3arPyjorajJ20K5IAWbz6MXSce4jdb/
5UK33yis6wQotLuHvsjNFvne773+j2NrS8Xt9X9clFxkvY1KXP+/HM36yFaKsS9rExdl9SC6
FMfNYqVWqSS1KNr7Q3fR5keb+ko51g0rxT02Xd51FzlxUxYdYOMri2I0KjfbXR9N6v22vga1
Kzkfi5ReEvV+G5Oa1KQmNalJTWpSk5rUpCY1qUlN6qNCvd/Wh0V9lV8ln+BRJzWpSU1qUpOa
1KQmNalJTWpSk5rU00HN/zPCuUJqUpOa1KQmNalJTWpSk5rUpCY1qUlNalKTmtSkJjWpSU3q
6aLm7/A4V0h9Mql5XZKa1KQmNalJTWpSk5rUpCY1qUlNalKTmtSkJjWpSU1qUpOa1KQmNalJ
TWpSk5rUpCY1qUlN6umj5tPNnCuknj5qXpecK6QmNalJTWpSk5rUpCY1qUlNalKTmtSkJjWp
SU1qUpOa1KQmNalJTWpSk5rUpCY1qUlNalKTmtR8YvX4jTqpSU1qUpOa1KQmNalJTWpSk5rU
pCY1qUlNalKTmv8ne7pHndSk5nU5faNOalKTmtSkJjWpSU1qUpOa1KQmNalJTWpSk5rUpCY1
qUlNalKTmtSkJjWpSU1qUpOa1KQmNalJTWpSk5rUpCb1tFHvtzUNA84VUpOa1WS6R53UpCb1
SaJmDSQ1qUlNalKTmtSkJjWpSU1qUpOa1KQmNalJTWpSk5rUpCY1qUlNaj7pcpRHndSkJjWp
SU1qUpOa1KQmNamPIjVXkJwrpCY1qUlNalKTmtSkJjWpSU1qUpOa1KQmNalJTWpSk5rUpCY1
qUlNalKTmtSkJjWpSU1qUh8Faj6PSGpSk5rUpCY1qfHUvCMhNalJTWpSk5rUpCY1qUlNalKT
mtSkJjWpSU1qUpP6KFDvtzV/a8C5QmpSk5rUpCY1qUlNalJPPzVXNZwrpCY1qUlNan5KTtOo
k5rUpCY1qUlNalKT+vhT806bc4XUpCY1qUlNalKTmtS8ZyU1qUlNalKTmtSkJjWpSU1qUpOa
1KQmNalJTWpSk5rUpCY1n+A6SaNOalKTmtSkJjWpSc27v5M06qQmNa/L6Rt1UpOa1KQmNalJ
TWpS85512ked1JwrpOZceTmr+VEYuqM56pzrx3XUSc27RM6Vk0DNGc65crypOcM56idl1I8m
9VE/4Udz1El9vKin9OI45qPOT07O9WmYNaSejiv0RUzT63Twx/9+62hO2BN3wJxmvAc4UqNO
6uNFzRnOusJRP6mjfjSpOVeO61zhqHPUp2HUWWGO61wnNevKNPBPBcTUTt1mrdWGnbeJzh2y
c0F27pGdx8jOi8jOS8jOy8jOK8jO7UFq0/XrHVrjLLTIWWiVs9AyZ6F1zkILnYVWOgstdRZa
6xy01jns/Ry01jlorXPQWuegtc5Ba52D1joHrXUOWusEWusEWusEu3iF1jqB1jqB1jqB1jqB
1jqB1jqB1joPrXUeWus8tNZ57P+pg9Y6D611HlrrPLTWeWit89BaF0NrXQytdTG01sXQWhdj
fy0BrXUxtNbF0FoXQ2tdDK11RWitK0JrXRFa64rQWleE1roi9new0FpXhNa6IrTWFaG1rgSt
dSVorStBa10JWutK0FpXgta6EvaBE2itK0FrXQla68rQWleG1roytNaVobWuDK11ZWitK0Nr
XRn7dB201pWhta4CrXUVaK2rQGtdBVrrKtBaV4HWugq01lWgta6CfZQY/Cwx9mHiCPs0cYR9
nDjCPk8cYR8ojrBPFEfYR4oj7DPFEfah4ghb9dAKBbbqgSUKsEUB1ijAHgVYpACbFGCVAutS
WKxMYbE2hcXqFBbrU1isUGGxRoXFKhUW61RYrFRhsVaFxWoVFutVWKxYYbFmhcWqFRbrVlis
XGGxdoXF6hUW61dYrGBhsYaFxSoWFutYWKxkYbGWhcVqFhbrWVisaGGxpoXFqhYW61pYrGxh
sbaFxeoWFutbWKxwYbHGhcUqFxbrXFisdGGx1oXFahcW611YrHhhseaFxaoXFuteWKx8YbH2
hcXqFxbrX1isgGGxBobFKhgW62BYrIRhsRaGxWoYFuthWKyIYbEmhsWqGBbrYlisjGGxNobF
6hgW62NYrJBhsUaGxSoZFutkWKyUYbFWhsVqGRbrZVismGGxZobFqhkW62Y4rJvhsG6Gw7oZ
DutmOKyb4bBuhsO6GQ7rZjism+GwbobDuhkO62Y4rJvhsG6Gw7oZDutmOKyb4bBuhsO6GQ78
dy7Af+gC/ZcusFUP/LcuwH/sAvzXLsB/7gL89y7Af/AC62Y4rJvhsG6Gw7oZDutmOKyb4bBu
hsO6GQ7rZjism+GwbobDuhkO62Y4rJvhsG6Gw7oZDutmOKyb4bBuhsO6GQ7rZjism+GwbobD
uhkO62Y4rJvhsG6Gw7oZDutmOKyb4bBuhsO6GQ7rZjism+GwbobDuhkO62Y4rJvhsG6Gw7oZ
DutmOKyb4bBuhsO6GQ7rZjism+GwbobDuhkO62Y4rJvhsG6Gw7oZDutmOKyb4bBuhsO6GQ7r
Zjism+GwbobDuhkO62Y4rJvhsG6Gw7oZDutmOKyb4bBuhsO6GQ7rZjism+GwboZg3QzBuhmC
dTME62YI1s0QrJshWDdDsG6GYN0MwboZgnUzBOtmCNbNEKybIVg3Q7BuhmDdDMG6GYJ1MwTr
ZgjWzRCsmyFYN0OwboZg3QzBuhmCdTME62YI1s0QrJshWDdDsG6GYN0MwboZgnUzBOtmCNbN
EKybIVg3Q7BuhmDdDMG6GYJ1MwTrZgjWzRCsmyFYN0OwboZg3QzBuhmCdTME62YI1s0QrJsh
WDdDsG6GYN0MwboZgnUzBOtmCNbNEKybIVg3Q7BuhmDdDMG6GYJ1MwTrZgjWzRCsmyFYN0Ow
boZg3QzBuhmCdTME62YI1s0QrJshWDdDsG6GYN0MwboZgnUzBOtmCNbNEKybIVg3Q7BuhmDd
DMG6GYJ1MwTrZgjWzRCsmyFYN0OwboZg3QzBuhmCdTME62Z4rJvhsW6Gx7oZHutmeKyb4bFu
hse6GR7rZnism+GxbobHuhke62Z4rJvhsW6Gx7oZHutmeKyb4bFuhse6GR7rZnism+GxbobH
uhke62Z4rJvhsW6Gx7oZHutmeKyb4bFuhse6GR7rZnism+GxbobHuhke62Z4rJvhsW6Gx7oZ
HutmeKyb4bFuhse6GR7rZnism+GxbobHuhke62Z4rJvhsW6Gx7oZ/vDcjBwbuDWSleHqUqFc
6PYbhXU9zYV2d7XQ39w4xD4ibUXv01dbiqPdr9p8+k/O6trZxUVnI32f9SUf5Ux0iAxXbcP+
oNYzJrfe3qx1Vq/+vmvlj2hbiR6/7yFTLmRjfUsu1//8r68UbsxF3/z9Vxz4kNvdeq291u0P
CtlXja7Oo84e73vHaIdLrU6zuzSaeJPz7pCPjY2NbXd7TU60wqZffd9tt5pvfd15NBAbGxsb
GxsbGxsb28vYBhs299P6emr8/Z3j1xuC12+O21b++4P8N4L8U0H+f4P87wT5/wnyLwT5/w7y
pRsm818P8sMg/0KQ/1CQ/68g/9Ug/59BfunUZP4/gvx6kP/3IP8bQf7fgvwXg/zXgvwbXzGZ
/9cgnwT5rwb5Dwb5fwnynw3yXwny3/vKyfw/B/kngvyXg/wHgvw/BflPBPl/DPLf+S2T+S8F
+fNB/otB/pkg/w9B/qNB/u+D/M2nJ/N/F+QfCvJ/G+TfHeS/EOT/MMh/Psi/6lWT+c8F+XuD
/GeD/NNB/jPj/Lnx978b5D8d5L8R5J8f5+8Yf3/2xsn83wT5zSD/qSD/oSD/10H+K0H+k0F+
fmYy/4kgvxrknwvyHwzyfxXkPx3kPx7kX5+fzP9lkL8Q5D8W5J8J8n8R5P8syD8b5F/96sn8
R4P8W4L8+HLPFcevTwd5NjY2NjY2Nja249FqjVwuvSd8JL3Ru2Vn/f8HN+dyP6txv8bNGs++
Npd7r8bbNL5H4/nX6D2yRlNjVuPLN+Vyv6XR0yhpfF3vHz+s8U6NezROa/yx3rP+vMYjGt+u
8ZzeQ79fo6pxm8YX9J7+1zTaGgWNr+ka47c1LmmcS9cbGr+n66J3adyvcdPp0TrtvRqPa7xe
43ldN/6KRqIxq/ElvbH9TY2ehtd4QdfVH9Z4h8bdGqc1PqLH/p4bRmPw8P/zhvdFPhiV/dNL
BsNex0TjjX2lHIuLKnttvKBbXEyGG6Y/rNeT7Uey7AH6zR7kmthM99ZJNg+2NalJTWpSk5rU
pCY1qUlNalJfP+r9Nr029X5bX5M69mVtuvnxp07X/7+qa94PnBqt/7d+//MRXfO/U+M+jVMa
f6Rr/qc1HtB4pcaf6Jr/ZzQe0jit8ae65n+XxsMaN2r8ua73f07jhzTyGs/qev/dGo9q3KTx
MV3vv0fjvMZrNT6u6/1f0LigcYvGc7rW/0WNt2m8TuOTutZ/RuPtGt+m8Sld6/+SxhMa3zFe
9/+yRlXjuzQ+o2v992nUNL5b43OnRsf4/lP7rd7ZpqgdjmN20BoYKm7Y7iNo976C7b6M7b6E
7b6I7T7Gdu+x3Qu2e4ftHlv1PLbqCbbqCbbqCbbqCbbqCbbqCbbqCbbqCbbqCbbqCbbqOWzV
c9iq57BVz2GrnovRazw2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2tkNq/wfPAv27AEgD
AA==

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--yrj/dFKFPuw6o+aM--


