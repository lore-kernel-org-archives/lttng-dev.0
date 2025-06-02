Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A2EC54FB3
	for <lttng-dev@archiver.kernel.org>; Mon,  2 Jun 2025 14:41:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4b9xNq5Fc0z1HsC
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1748875278;
	b=dS7vOLzVBDYfRqwCnV9Vb2chQH0RzWEjXG65nMIN8nOfuO2qAn27QKU31eD9ZO0sNexW
	 2qz0FQF+5RKu0PKCbSlH3AFpIb3TTs1AjrIVwUxyWHBHlGmiTtApsHrctKH09ZIhPlKxn
	 h8DDBKgVwtXnFsq4W+4HHYfcyiaJD0bvyJVvp2KUShdONDSsgHkG6PGVMD6gEVAE4Vy8Y
	 FOMSDnjyKBZlLZAmyhnIKlmdjyfjFfbLEjHCnRSgpTFUI17cRTTE7yEOhWclfbDcUKKLK
	 gSCWhPoaqIxrMbUMGZHtfpk1fs1y2eZxaVYeAtA4jpZxSwZXE9wol8A/R23rS05BV1g==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1748875278;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=yxf42VREK2o8xXFVWDHHAqXJeVfqJnutI+EC/VcoWSo=;
	b=IRuLGrxd6Q6uaBpTuuGWAMj1Dkx4ZZVzl55mXqgblATLM7hwiG7dJLjTGUM056HWascy
	 pXJ4FNWz8eNMdN0+fXfTHxEpM6osgmUy+kQSlM8mmj3+ac9lrYIEZuL1VAJjXHP+oTNXV
	 9s/8Nn6yKiYbH6A117T/1g+Bjzf/5JqyB0MEB+1lJLyQcva8jQaSkJJzv+pbxowiRRQ0+
	 UkYuUz5hACRdJS7QwSB2JCvZGy995ycE0ynSoZZjgVCz88MFlvOVlEeckd5EZSFJibW7e
	 e3A90AACF6GkwbzETY/ZqV0D+wIYUp5LMrM4p3uA0DHVi8qIKIVX0dOEZg/yrQrGVvw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4b9xNq5Fc0z1HsC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1748875278;
	bh=yxf42VREK2o8xXFVWDHHAqXJeVfqJnutI+EC/VcoWSo=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=S4elb/QrLzGXBK7FKAR3HqgeYWVk8xcuSI+BT9RGuQ/Jl6q9Q7VrJzxx8i1oou5Gv
	 fiQ7ZZ6nt8KP7bihJ6qMsEnQG79yu06O+cemPWke7B2eP3odegqPLFFEKpwH/rzh9u
	 KdHhdheSJJswFYw5GD7YesqeitfcIK4A53ZgdGlnmdbHx2mmbtBDbNlRDK7b1hnJ70
	 YLqMoyOD/XkW5jKEbMm6aqJQCVqvxqvE5tcKz7HV5KgMFAbZ+w5tm5qKvgnj+u3qse
	 n7j3VAodCdYdgSbsXXME+jxhphaQltEYuqEtyYHDWiLGl7B/F2QgP6sZIuHn8uvPEK
	 kFaZ0Vs/EE0Ag==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4b9xNq5Fc0z1HsC;
	Mon,  2 Jun 2025 10:41:15 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4b9xK21sNzz1HRw
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4b9xK21sNzz1HRw
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by lists.lttng.org (Postfix) with ESMTPS id 4b9xK21sNzz1HRw
 for <lttng-dev@lists.lttng.org>; Mon,  2 Jun 2025 10:37:57 -0400 (EDT)
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4a588338015so25038061cf.0
 for <lttng-dev@lists.lttng.org>; Mon, 02 Jun 2025 07:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748875072; x=1749479872;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=83WVKbvfXpL9QvquFE99ZdEcnQDXHRawufcMAEZT+tw=;
 b=U9cx65Tnt6wA7teXspNgHB1MuMR0hRTKVnwcEC7t23Aet23BGQwrNgjDq5mo2WhhLQ
 57mv+7yPJrnlW/TDd0G0AZ4oDZPqxAVmJMPi1Y8R44JK5HyYvxN1PojlU4vrbNtHt4NQ
 ycJiy1867CT3pv5kgRGeYt7pyguaI87xlzaOpZD9Fa+Kb0WCSCvJhvUqoXLGf3uCVBm7
 JO22yJjkJMLV2BXD/bDKlBqSgU23Fp/THk/+szot+a7W/KXtXGpjg91tvlx5ioXGr33H
 yDk74IP7dNYVdfNJW8lbyZypawxUkO6dIjfgGLpNY4wTzDTNl+UNGc1rZhunPXNMB7Ku
 JvBQ==
X-Gm-Message-State: AOJu0YxAORY4fN2iiwXhxU2SOf8e07gbQAm+Qim8KNuiE64MR4N1Z8lv
 txmLSk2mXTMf0FjiKTjM050RY8nbVu314FRMFifPtFBcVTcuL3ib5XczezDHAxRxnYdkb7pwdo/
 EWD76h7grRPZQAW84D8+LG0MYBTD0rHyZdMy/
X-Gm-Gg: ASbGnctHzxslvQwZzCg1nxCGhcWDjZO//CuEQoLbW8beWt/usFd8hrg7eLjCy9SONxj
 TxPD6K9atEvCkh5V4Nf6ihXMw8548qJAWHmQnVxCg07TQbhDpxLU9hLQVsTe/d3T1YcrWGf4om/
 uLCueGZ96wAixT/jRV1LnDHeyrZKyXQbwvbg==
X-Google-Smtp-Source: AGHT+IF4y7Ig/lR94FHcuApShko/RGmQG/9Ev43bShNh0an/golxn4AGE5nOaUIuzJTyPsypGO2ld3N3DxWbye6d1dg=
X-Received: by 2002:a05:6902:4791:b0:e81:22c8:d217 with SMTP id
 3f1490d57ef6-e8122c8dbc3mr12345620276.8.1748875061086; Mon, 02 Jun 2025
 07:37:41 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 2 Jun 2025 15:37:30 +0100
X-Gm-Features: AX0GCFu_5E78sau6pTley7BbpxoRF7i85OuKqvKRJ_NodPDNKphyHa4_h2goS2w
Message-ID: <CAJK_ieigCAaowdcwmLbkdL1J3eFgHE7t1W=ZKRvoKhgABM46yw@mail.gmail.com>
Subject: Function tracing not working
To: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 02 Jun 2025 10:41:13 -0400
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

Hi,

I am trying to use lttng-ust-cyg-profile.

Our application is large so, so far, I only compile main.cpp with
compiler option '-finstrument-functions' (I don't specify option
'-pg').

Our app must be run as root so I run it, and capture with lttng, like this:

lttng create app_trace
lttng enable-event --userspace 'lttng_ust_tracef:*'
lttng enable-channel --kernel --session app_trace kernel_channel
lttng enable-event --kernel --all --channel kernel_channel --session app_trace
export LD_PRELOAD=liblttng-ust-cyg-profile.so
lttng start
sudo -E ./myapp
lttng stop

I notice that many events get discarded:

Warning: 198522 events were discarded, please refer to the
documentation on channel configuration.

I then import into TraceCompass.  I see the traces in the Resources
View, but when I expand Experiment > Views, all 3 'LTTng-UST
CallStack' entries are striked through so I can't select them. So I
can't visualise the function calls.

Any idea what I am doing wrong please?

Best regards, David
