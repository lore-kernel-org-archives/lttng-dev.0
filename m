Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484D8C433EF
	for <lttng-dev@archiver.kernel.org>; Tue, 31 May 2022 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1654002689;
	bh=5izOC1wIUDLIsPfVl49uiraAokWca2Cc/cjEdoLBW2Y=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=F7SKL7YMios5nyNXBmsMP6i6GWn3u6d9T5aGU6ahzeeRG7JRuVgwMczKprKDxh8zv
	 miaVgQSAwJKHnTaNpWnHV2lPTRSpjlA3BT0qKFU73vxYZtn9ETD7TWWR6YxgG68Imx
	 3VvpRkhMybO+tXvWAKrNQV0V0XX6DyINtgAB3voCsEyqUN0EXe2NLd8Gknt8K6/PYb
	 oYQ026AKX2po3wjPQxp2dE8QnABX8jSjDFeI3OKcgfykKlq/t1Bd3xS1O051WlAeZI
	 Qr0qwUFj5Dh5SVuG7geHTGvP26BYNjz/5yWKmRsI6GJL9JUAAZohMdzLU8hStprFC4
	 xxvCMbQDkLHeA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LCCN04Mnwz2wH;
	Tue, 31 May 2022 09:11:28 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LCCMz0xwsz3fL
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2022 09:11:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 909053FA809
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2022 09:11:25 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id I6MwccIEQitq; Tue, 31 May 2022 09:11:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EBB963FA78F;
 Tue, 31 May 2022 09:11:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EBB963FA78F
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id rY9zHi3j0dc0; Tue, 31 May 2022 09:11:24 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id E1F883FA3D1;
 Tue, 31 May 2022 09:11:24 -0400 (EDT)
Date: Tue, 31 May 2022 09:11:24 -0400 (EDT)
To: Marcel Hamer <marcel.hamer@windriver.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1268831549.13571.1654002684841.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220531112855.GA856582@windriver.com>
References: <20220530141021.267219-1-marcel.hamer@windriver.com>
 <769020238.11656.1653924475516.JavaMail.zimbra@efficios.com>
 <20220531112855.GA856582@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4257)
Thread-Topic: cleanup stream on snapshot failure
Thread-Index: lvQgNJ71Ad0EWx+tAetq1AEzFtcrKQ==
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: cleanup stream on snapshot
 failure
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Marcel,

This is exactly the kind of reproducer we are looking for.

Thanks for providing it. I'll try it out and check if we need anything more in that patch.

Cheers

----- Original Message -----
> From: "Marcel Hamer" <marcel.hamer@windriver.com>
> To: "jonathan rajotte-julien" <jonathan.rajotte-julien@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Tuesday, May 31, 2022 7:28:55 AM
> Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: cleanup stream on snapshot failure

> Hello Jonathan,
> 
> On Mon, May 30, 2022 at 11:27:55AM -0400, Jonathan Rajotte-Julien wrote:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>> 
>> Hi Marcel,
>> 
>> Thanks for sending this patch.
>> 
>> Looks sensible to me, still do you have a reproducer for it? I went back to bug
>> 1352 and even with https://bugs.lttng.org/attachments/546 was unable to force
>> the assert failure.
> 
> I can only reproduce it when running lttng-consumerd in a debugger
> environment, in my case gdb. My reproduction scenario is:
> 
> 1. Setting a breakpoint on snapshot_channel() inside
>   src/common/ust-consumer/ust-consumer.c
> 2. When the breakpoint hits, remove the the complete lttng directory
>   containing the session data.
> 3. Continue the lttng_consumerd process from gdb.
> 4. In that case you see a negative return value -1 from
>   consumer_stream_create_output_files() inside snapshot_channel().
> 5. Take another snapshot and you will see lttng_consumerd crash because
>   of the assert(!stream->trace_chunk); inside snapshot_channel(). This
>   last action does not require any breakpoint intervention.
> 
> The scenario seems to be very timing sensitive to reproduce. I do not
> have a clear command sequence to achieve the same error.
> 
> The proposed patch prevents lttng_consumerd from crashing in step 5.
> 
> Kind regards,
> 
> Marcel
> 
>> 
>> Cheers
>> 
>> ----- Original Message -----
>> > From: "Marcel Hamer via lttng-dev" <lttng-dev@lists.lttng.org>
>> > To: "lttng-dev" <lttng-dev@lists.lttng.org>
>> > Sent: Monday, 30 May, 2022 10:10:21
>> > Subject: [lttng-dev] [PATCH lttng-tools] Fix: cleanup stream on snapshot failure
>> 
>> > When a channel snapshot creation fails the stream should be cleaned up
>> > properly. If the stream is not closed and cleaned properly on a failure,
>> > the next time a snapshot is created an assert is triggered for:
>> >
>> >       assert(!stream->trace_chunk);
>> >
>> > inside the snapshot_channel function. Since the stream->trace_chunk was
>> > not reset to NULL. The reset to NULL happens inside the
>> > consumer_stream_close function.
>> >
>> > Fixes #1352
>> >
>> > Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
>> > ---
>> > src/common/ust-consumer/ust-consumer.c | 10 +++++-----
>> > 1 file changed, 5 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/src/common/ust-consumer/ust-consumer.c
>> > b/src/common/ust-consumer/ust-consumer.c
>> > index f176ca40a..f43216829 100644
>> > --- a/src/common/ust-consumer/ust-consumer.c
>> > +++ b/src/common/ust-consumer/ust-consumer.c
>> > @@ -1147,13 +1147,13 @@ static int snapshot_channel(struct
>> > lttng_consumer_channel *channel,
>> >               if (use_relayd) {
>> >                       ret = consumer_send_relayd_stream(stream, path);
>> >                       if (ret < 0) {
>> > -                             goto error_unlock;
>> > +                             goto error_close_stream;
>> >                       }
>> >               } else {
>> >                       ret = consumer_stream_create_output_files(stream,
>> >                                       false);
>> >                       if (ret < 0) {
>> > -                             goto error_unlock;
>> > +                             goto error_close_stream;
>> >                       }
>> >                       DBG("UST consumer snapshot stream (%" PRIu64 ")",
>> >                                       stream->key);
>> > @@ -1170,19 +1170,19 @@ static int snapshot_channel(struct
>> > lttng_consumer_channel *channel,
>> >               ret = lttng_ustconsumer_take_snapshot(stream);
>> >               if (ret < 0) {
>> >                       ERR("Taking UST snapshot");
>> > -                     goto error_unlock;
>> > +                     goto error_close_stream;
>> >               }
>> >
>> >               ret = lttng_ustconsumer_get_produced_snapshot(stream, &produced_pos);
>> >               if (ret < 0) {
>> >                       ERR("Produced UST snapshot position");
>> > -                     goto error_unlock;
>> > +                     goto error_close_stream;
>> >               }
>> >
>> >               ret = lttng_ustconsumer_get_consumed_snapshot(stream, &consumed_pos);
>> >               if (ret < 0) {
>> >                       ERR("Consumerd UST snapshot position");
>> > -                     goto error_unlock;
>> > +                     goto error_close_stream;
>> >               }
>> >
>> >               /*
>> > --
>> > 2.25.1
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
> > > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
