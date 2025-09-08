Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02E6CA101F
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Sep 2025 00:11:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cKnRc2MdTz1jKp
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1757290269;
	b=T5i9fgYhGKpiEvhNfOuYfVuOkGziIjGgXuBZYE9KvHIVaLXVJTiK2jHqV2Dph3L7XuZk
	 k12Bf5T30Pi826xKdAjntKTWf8pJDBG19wtr5IPudevcxsQAfo5Sqoesdcfhd+DxwTjWw
	 +uLssyfauc+b98gJtoQuFiqzE5qRJX9O+NNwXZTh0VokOFwnGjFDhM513SWXlHqsFtFD9
	 wZnn+8FWpVJx2l29UhZ5npBtek3SN6NZdDtwmwTCrWlJR0VKEeA1juRaMdHIDJWv3yacD
	 9FxlTyBIrJTJGg6HMVI2pZDkpCXJ4OmT/zPFleeMX4saGYHTCsVdpevqx5JpqFbJ7sg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1757290269;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=P/hVrdNrFyko0waD4g1KIXxzPqA0dtjuxJpjQ9t8Ir4=;
	b=XgDZp2xeXndXOfjdlNBBKqItkccUCivlZP3wF/qjG2iFDTP1PIbPDdyJT4KYnWpLd2lV
	 JXXtyTbf4f06uULLFOhq4KHSNL5AicmEmFXrf533IVgmZs+wjZAYIfryqubc8fDb1GX6y
	 J/EmGjlGuiYL9pWqgIrFr6IHi+EtqYXSFOu0EUBceNfi9mHpuYWI2GySDfGrAeriy+E+f
	 /j90A7qjQyUCy0iGkRedzgDqqrhw5553NcN0c/HoV41mBbnEDrUzSUEaPBVRQ5fQ5z/0C
	 AAS9Q6teTu71S/Y2JeGSlm/NfoVLF9eyjgL3b30/CixvUt/qDvRJJ8nKTQ0n15T+jcQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cKnRc2MdTz1jKp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1757290269;
	bh=P/hVrdNrFyko0waD4g1KIXxzPqA0dtjuxJpjQ9t8Ir4=;
	h=To:Subject:In-Reply-To:References:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=A3mNR4x0ZHupHI3DS+U6QgDBLeYdbh+T5qFAfBPrErBifG96Dxfr0LZkh3/ANcRZm
	 owuKlxGlxHfiVVlN84HulIWQT8Yqy2GlKdR3Hb0UMab28b8ro/DRTMpwNUgX3HZyqA
	 i0CBDtxfxbxskTPrYDAMEjE0wkIdlM193BsbKAbmA7y8jjiRsfMTZrYrmlV6mX3PcW
	 E+WNN1bxEDEcdq24StJn7HBkxOcaIcTscu963YmqC1MtCpSkRryGR2Qdn+SVObui5C
	 dlnLfsc7suxnCrLV+exWAsDy1eeO7Zo71VjHoCPwNyMoXR68WRxQXL7JKGxVC6QG5x
	 09Uf0mQ3LXwfQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cKnRc2MdTz1jKp;
	Sun,  7 Sep 2025 20:11:08 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cKnRZ0rW2z1hvm
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cKnRZ0rW2z1hvm
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
 by lists.lttng.org (Postfix) with ESMTPS id 4cKnRZ0rW2z1hvm
 for <lttng-dev@lists.lttng.org>; Sun,  7 Sep 2025 20:11:05 -0400 (EDT)
Received: from localhost (199-193-172-8.cpe.axion.ca [199.193.172.8])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4cKnRQ0vy5z94J;
 Sun, 07 Sep 2025 20:10:58 -0400 (EDT)
To: Thobias Knudsen <thobknu@gmail.com>
Subject: Re: URCU feature request?
In-Reply-To: <CAKGpciqOVQRTP9kz7uwFFECGWMzFRFRsRujSDBrxFC24Y1A6NA@mail.gmail.com>
Organization: EfficiOS
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
 <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
 <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
 <CAKGpciq+ixOVGN7TXYaF336ZEL_mOejzic5BvaKbexwwn_aqOQ@mail.gmail.com>
 <BD1A29BD-2AD2-4092-B1A2-DFEFAE77AAEE@sury.org>
 <CAKGpcip6w2nVQ+vbtfFH1296xTi5HYX+68J8okecChsihejDQA@mail.gmail.com>
 <87y0qwwc6j.fsf@laura>
 <CAKGpcioZbhyTUqLmNSnpuPw=jbi6eZV6ubbFQtvFD6VKn3wKxA@mail.gmail.com>
 <87h5xg7p3u.fsf@laura>
 <CAKGpciqOVQRTP9kz7uwFFECGWMzFRFRsRujSDBrxFC24Y1A6NA@mail.gmail.com>
Date: Sun, 07 Sep 2025 20:10:57 -0400
Message-ID: <87bjnlrege.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Sun, 07 Sep 2025, Thobias Knudsen <thobknu@gmail.com> wrote:
>> It looks like you want runtime verification for the usage of the API.
>> Did you know that URCU can now be compiled against ThreadSanitizer
>> (TSAN)?  If a user misuses the API or makes incorrect assumptions about
>> the guarantees offered by RCU, TSAN will most likely detect those
>> issues.  Coupled with the other debug features we already have, this
>> makes it very hard to not trigger an error path when the API is used
>> incorrectly.
>
> Really?! I've used TSAN and got a bunch of false positives, I believe, but
> maybe they're not false positives? How do you remove the false positives,
> or know that they're not false positives?

Since 0.15.0, we've introduce an annotation layer (not part of the
public API), making TSAN compatible with URCU.  See
`include/urcu/annotate.h' and the `CMM_SANITIZE_THREAD' macro.

However, IIRC, you also need to compile URCU with the configuration
option `--enable-compiler-atomic-builtins' so that atomic operations are
implemented with the configured toolchain's builtin atomics.  I don't
recall if this was stricly necessary.

If you encounter false positives with TSAN, please send me a minimal
reproducible example together with:

 - the toolchain you=E2=80=99re using
=20
 - the version of URCU
=20
 - the configuration flags you used

I will be happy to have a look.

>> Note that certain kind of errors could actually be flag at compile time
>> with the proper tooling.  For example, the Linux kernel uses a `__rcu'
>> attribute that Sparse can understand to flag improper use of
>> RCU=E2=80=91protected pointers.  I=E2=80=99d be very open to exposing so=
mething similar
>> (an attribute) for static checkers.
>
> wow thanks for the info! I knew compile time checks would be possible but
> requiring compiler operability which is a higher hanging fruit for me.=20

I don=E2=80=99t know the details of `__rcu' from the Linux kernel. I think =
it=E2=80=99s
just a macro that expands to nothing by default, but Sparse treats it as
an attribute.  I=E2=80=99m not sure exactly what checks Sparse performs wit=
h it,
but I suspect it involves traversing the program=E2=80=99s control-flow gra=
ph
(CFG), ensuring that pointers marked with the `__rcu' qualifier are:

  - obtained via rcu_dereference
=20=20
  - only dereferenced under RCU lock protection

> Is '__rcu' compatible with custom concurrency? For example
> rcu_dereference a pointer then locking a mutex inside the pointer then
> unlock read then continue using the pointer?

I don=E2=80=99t see why that would be a problem for the static-check algori=
thm I
described above.  If a pointer needs to be protected by a mutex for
mutation, that falls outside the scope of RCU, as far as I know.

> I cant come up with something usefull other than a language rework. Is
> it much work making the __urcu attribute?

I suppose not.  On top of my head, it would involve adding some pointer
qualifier and function attributes to the primitives exposed by URCU.
Users would also need to use the pointer qualifier when working with
RCU-protected pointers.  The qualifier and the attributes would expand
to nothing by default, letting static checkers defining them to internal
values.  I suggest you read `Documentation/RCU/rcu_dereference.rst' in
the Linux kernel tree if you are interested.

In its current state, this would not be very useful because none of the
major compilers provide static analysis for RCU.  However, implementing
such analysis, as a plugin, wouldn=E2=80=99t be overly difficult for someone
familiar with Clang or GCC, I suppose.

[...]

Thanks,
Olivier
--=20
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
