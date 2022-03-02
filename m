Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62937C433F5
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Mar 2022 09:27:43 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4K7pgK4jp5z5Qh;
	Wed,  2 Mar 2022 04:27:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646213262;
	bh=vZTCq4OYgUOJ3RuaZqjSSac/zY4wDghHk7UjWiH4qZo=;
	h=Date:To:CC:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FP6p9J9Z0IVrQE+T8Y8xYkPRHWa76dIRzW4dRHhA4cd8mSLUoeZ+zVk46Wq+Shvkx
	 VMuClv9BP10EwmixVVytvQVlyyrriOBw92IgXdBIO3fuaAoaD9gkF/fcMxXt7sIUBN
	 vbbM+KpDpGOGQlVg7rnVD0Wlk7UAtYGpJIDSMoSZuz87v9z6NKnq3gAqSCddM+eFh1
	 7FKCFUvv3p/MiEV38S7doOAHOZyZHtUC3AHDB7l9HdlzPGiPI6BAqTT1xbtsJIOALb
	 Zg85YMio3kWSaGPajkshTq5fbtnHApg1Sa9np1oxZ5yJAEbtuzpl/8GM8+9QraCyVa
	 mbPcId7c1I4+A==
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by lists.lttng.org (Postfix) with ESMTPS id 4K7pgH312nz5kZ
 for <lttng-dev@lists.lttng.org>; Wed,  2 Mar 2022 04:27:39 -0500 (EST)
Date: Wed, 2 Mar 2022 10:27:30 +0100
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>, kernel <kernel@axis.com>
Message-ID: <20220302092730.GA26479@axis.com>
References: <20220225151202.4148809-1-vincent.whitchurch@axis.com>
 <1019241870.115039.1646155163638.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1019241870.115039.1646155163638.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: consumer-stream:
 use-after-free of metadata bucket
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
From: Vincent Whitchurch via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, Mar 01, 2022 at 06:19:23PM +0100, J=E9r=E9mie Galarneau wrote:
> Thanks a lot for reporting the problem. If I understand the ASAN
> report correctly, the stream itself will also be double free'd, so
> I don't think this is the complete fix.

Yeah, it looked odd that consumer_stream_destroy() is called recursively
on the same stream but AFAICS the code's been like this for a while so I
assumed it was on purpose, and only the metadata bucket stuff was
relatively new.  ASAN doesn't detect any double frees of the stream
itself, but I guess calling call_rcu(..., free_stream_rcu) twice on the
same stream is not expected behaviour and could lead to other problems.

> There definitely seems to be a problem with regards to the ownership
> of the metadata channel vs stream. Let me look into it.

Great, thank you!

> I see that you fall into a case where the metadata setup fails,
> can you share more info about how this can be reproduced?

In the core dump I received (on v2.12.4), consumer_stream_destroy() was
called from the error label in setup_metadata and ret was set to
LTTCOMM_CONSUMERD_ERROR_METADATA.  So consumer_send_relayd_stream() had
returned an error.  I only had the core dump and no other logs, so I did
not know which of the paths inside consumer_send_relayd_stream() had
failed, but since I was primarily interested in fixing the crash itself
I simply forced this code path to be taken:

diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consum=
er/ust-consumer.c
index fa1c71299..97ed59632 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -908,8 +908,7 @@ static int setup_metadata(struct lttng_consumer_local_d=
ata *ctx, uint64_t key)
 =

 	/* Send metadata stream to relayd if needed. */
 	if (metadata->metadata_stream->net_seq_idx !=3D (uint64_t) -1ULL) {
-		ret =3D consumer_send_relayd_stream(metadata->metadata_stream,
-				metadata->pathname);
+		ret =3D -1;
 		if (ret < 0) {
 			ret =3D LTTCOMM_CONSUMERD_ERROR_METADATA;
 			goto error;

With the above patch, I could easily reproduce the use-after-free using
the following steps on the latest release v2.13.4, and it was clear that
this use-after-free was the cause of the original core dump on the older
release too.

Build with ASAN:

 lttng-tools$ LDFLAGS=3D-fsanitize=3Daddress CFLAGS=3D-fsanitize=3Daddress =
./configure

Shell #1:

 lttng-ust$ tests/compile/api0/hello/hello 10000

Shell #2:

 lttng-tools$ ASAN_OPTIONS=3Ddetect_odr_violation=3D0 ./src/bin/lttng-sessi=
ond/lttng-sessiond

Shell #3:

 lttng-tools$ export ASAN_OPTIONS=3Ddetect_odr_violation=3D0
 lttng-tools$ ./src/bin/lttng/lttng create --live && ./src/bin/lttng/lttng =
enable-event --userspace 1 && ./src/bin/lttng/lttng start && sleep 1 && ./s=
rc/bin/lttng/lttng stop

The ASAN splat should be seen in shell #2.  Note that you may have to
run the command in shell #3 a couple of times since
LTTNG_CONSUMER_SETUP_METADATA doesn't seem to be sent every time.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
