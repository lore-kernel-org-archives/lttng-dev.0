Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96F5C5AE59
	for <lttng-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:49:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bCh6G06yQz2C4G
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1749120584;
	b=V3ois6FbJYHlBZZrlmvkkZXsbc5euVbcTdKz5LM+FA06eecHM+70NFi/DMEGXN1aguyj
	 J6yomW/WZUnbcgSF/kTuv8cxziTDuxOOA9MWG1XwmNVXNish23HfZwrJggVYol1pg37Fa
	 KypJXNhuj1QGYk8U91P3bIpLbhA0tP8DQk9cQKQxF1EZGqHeg9WqoQqnaiLHS74WKtwgF
	 eY6voy7K4Iy+eDGJEgEAUAs+UyaoVKLPmxJEiZ/9nuR5tRQz037tVngpo5kBYXtW/3dZP
	 U3g+ajcBD5KXHIakxuc8PTucXxnf019Lw7cVoGHSUXee8uV5xLrZszuyoh/SEfu/reA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1749120584;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=soFbjZZ1lx3Ah7L2KZV51M7sT83ty8oYUtEMjJAzXeE=;
	b=dsdAXW3yPAt7HDcNbsp77uFoBK31MqtcPF7OX9eSUPXtN1/gDrU9iHQ60/feWAQcRUr0
	 XWcyrmcrRhIitw8h4R7235+vht8XEqm5SC3xK8I6VjUCiBgq+iyzrNZ1lofMJt3OTk7F3
	 eGnXo/Z3VxXIJ6DivqQysWO4gk/FnSMpKKpNnw5/nGN+vkGcgRN9Yg0Woby02+1SM+meQ
	 8Sqphaf/UaeXJJwsUUaMFgZystB1TIdMyK7meG2DrSnpV3CNnLKDKSWBdkeaA2Xl8b1kQ
	 xT6cUZA2ZuKDRJkXXaHj6n31taZ73DVfRbhm21zUA6XvGiwQXvUYMPi4HDtr+L4xyTg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bCh6G06yQz2C4G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1749120584;
	bh=soFbjZZ1lx3Ah7L2KZV51M7sT83ty8oYUtEMjJAzXeE=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rVCklthtv85haQETVErMOtJ5mwDSzA7QE4qdw3JIn/IanLGjQBrQ2Uy7pr15W3gYo
	 IResPx594YZmdAZ8FWU7aW8KbMFZcbXWKQNs0YZCba3wRIFzCE7HcTI4rayoCA5chz
	 IgpXbg5b2vnMdyCQ8t2f/0r0gZo6/iwySru3U0hJa4/ZYMYggdIal8GiBFXPpcAE9p
	 rbHTQ3uwzlerkT43ZTNp1p2ON2QDDQaAiASJS2Y7XShGP9zMtxkObiQAHUNEIwbcBf
	 L9EFknYO1S3t05bk1M1Omt+2x6xpknKJ8V0PLFoxXlxTHheiYzOETi56bKlP618xxh
	 HxcGFJxMiGeKQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bCh6G06yQz2C4G;
	Thu,  5 Jun 2025 06:49:41 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bCh6C5wQgz2Blh
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bCh6C5wQgz2Blh
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by lists.lttng.org (Postfix) with ESMTPS id 4bCh6C5wQgz2Blh
 for <lttng-dev@lists.lttng.org>; Thu,  5 Jun 2025 06:49:39 -0400 (EDT)
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e740a09eae0so794008276.1
 for <lttng-dev@lists.lttng.org>; Thu, 05 Jun 2025 03:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749120578; x=1749725378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SmgwQ5UmwjHL9Klx0VjdydO01jZWEs5rPADAQz72to=;
 b=NK0NntjtHaoz/Y0kbOEOrHR4aQAkvbXTWBISFPO5XdkdU6FdYMS65qxLvm3b6m0SGC
 LmRTg/OD5MuEfGT3KTQ4rwMo9CM7VkWZ8K/rwuaUkNk1G0DkDYwn/geJcmkbh5MJ80j5
 ljXLUtUe1OUy8RG5ry8savd+eIisAzoJ5628QCasENqKDEzs8qwUt47EVfoGYsHU4yC5
 aMjaKbIqP9gzbgiwI8WjdrytWZSxXE1SZ7DM4fiRie+VF/7U645fSBVSLfJ8H8JkhOOh
 CEhNRiUeWGIDQVUKh2j+XkqLvQm7aN4kyoj1FlGuNO/A59uxPFLqjkONaHcqjGfCRQa8
 kQng==
X-Gm-Message-State: AOJu0YziKx/WxIuB126LypB4uSEh4QBNyDys/HKnMhzCBFrjQSuSTF4j
 SQuMcxrhxHwi1DYkP8L0pD4m1hNwa1uwT0pRDwe7ITnDC9pkopF0TrZZ7JbklsUmOGGLZE71TyB
 fvXd7+HpuBwTzJcmhY6//CvSKASTQlrk=
X-Gm-Gg: ASbGncvyIcgKgSn1wFEqjYyWjz5SRqaBI5dv0ObmOht8tm3YENffLwu/2Zg4QdvYulQ
 kAqawJNxMOYehk30CGuB72/K68q/RsdXYV4qewg3uw289b45TyisQZSQRg+Ls/MEgek5jgQFq7I
 wL16UMI/s89Fot/Olnv4nJHmoTzfbiYalUKw==
X-Google-Smtp-Source: AGHT+IHyyMzGxsbjJi6eHaLVFE6Yz3RnPbrHQ0JLxJVmXKqf4Q1uZViBBNe5Nx56g25VBk4SNeALesZ6n0Q+kI6gWOc=
X-Received: by 2002:a05:6902:15ce:b0:e81:838b:c58c with SMTP id
 3f1490d57ef6-e81838bc7cemr6042589276.20.1749120578192; Thu, 05 Jun 2025
 03:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJK_ieigCAaowdcwmLbkdL1J3eFgHE7t1W=ZKRvoKhgABM46yw@mail.gmail.com>
 <cc6438cc-1836-4983-8f09-c569ee2cf11d@efficios.com>
 <CAJK_ieiG5yDoyg8TetipUJZNMhrpteZuY5CBv5eeUNE18AJq9Q@mail.gmail.com>
In-Reply-To: <CAJK_ieiG5yDoyg8TetipUJZNMhrpteZuY5CBv5eeUNE18AJq9Q@mail.gmail.com>
Date: Thu, 5 Jun 2025 11:49:26 +0100
X-Gm-Features: AX0GCFt2oSQBQmNqb_-XpKtO664urPqprdGdhFGktHNj7fkPb9tqKYunbNZFJI4
Message-ID: <CAJK_iej5GwQm6pjRuMxDJeYLu+YBjp0NTjh3xzvOCvOJ8aft3Q@mail.gmail.com>
Subject: Re: Function tracing not working
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
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
From: David Aldrich via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: David Aldrich <david.aldrich.ntml@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Mathieu

I'd like to add some more detail.  I now run our app using this pattern:

LD_PRELOAD=3Dliblttng-ust-cyg-profile.so ./app

On importing the trace into TraceCompass I see:

"null analysis for LTTng-UST CallStack"

Could the reason be the lttng commands I am using to capture UST and
Kernel events:

lttng enable-event --userspace 'lttng_ust_tracef:*'
lttng enable-channel --kernel --session app_trace kernel_channel
lttng enable-event --kernel --all --channel kernel_channel --session app_tr=
ace

Best regards
David

On Wed, Jun 4, 2025 at 5:22=E2=80=AFPM David Aldrich
<david.aldrich.ntml@gmail.com> wrote:
>
> Hi Mathieu
>
> > > Any idea what I am doing wrong please?
> >
> > AFAIK, the "LD_PRELOAD" environment variable is cleared by
> > sudo when running its child process for security purposes.
>
> Thanks for your answer, that does help. However, I have now adjusted
> the code so that sudo is not required, but when I import the trace the
> UST-CallStacks are still strikethrough.
>
> Any thoughts why this is happening?
>
> I don't see any runtime errors whether or not I specify the prefix:
>
> LD_PRELOAD=3Dliblttng-ust-cyg-profile.so
>
> Is that expected?
>
> Best regards, David
