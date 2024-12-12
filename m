Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F2AE77180
	for <lttng-dev@archiver.kernel.org>; Thu, 12 Dec 2024 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1734022629;
	bh=OlPUarVFORqw0sKmg7StXmbiYEwJzeNZsQc5DkG56Sw=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UybuWnoL42MUZ12Ligd5ZnlvOes9mQR7rG5dOnDmC+a4jYBbKE/1lfRTn/K/SJPVP
	 GYv4lmDIlTywWM4Km6fuz0jCQj21n6s1jC1gShPXsG0ItYbsHkcOvqOxu3WQFYNfUp
	 pfJCO7TtTSimmb9mDvkDeESoHGcXfS656LCsK9Wtede5H3sVCIjO12Da7olCz575Y1
	 qBzTtB6sqVB4UpnBJ+dXm5HNLATmoUKysoeIOJOEKvc5jwvolrr010mtFURkShBf3M
	 Bq/3VhCXV2roJHCqhmIqcCeDQ1sBwKMlVGhWjCFuclYgpduNVN5Wc1NlGdb5Cz9gxY
	 mr16ZB9yzJanw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y8JY12Wzgz197q;
	Thu, 12 Dec 2024 11:57:09 -0500 (EST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y8JY00drbz1935
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2024 11:57:07 -0500 (EST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso144592166b.0
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2024 08:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734022627; x=1734627427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OlPUarVFORqw0sKmg7StXmbiYEwJzeNZsQc5DkG56Sw=;
 b=c/rZkp43gakKO0LIPH8E69cW635KzzWlSDav3q1tLJFVrkclkdHgvJR0UBAre7IH+j
 mp377/b03K4LwdKemrAgAnw5IUQWjHHJ7UDoCKLz3oxh6fvcMByaC8Su/uEdTSd7EbS9
 knCRojmRME9ZVpXOwToX4JfhjlcdtbUWM4x1tvZB8dGYZzSG69WW19uAAegq6bsaGJwV
 1oVFNP0x3TGOenPUXBnW34KzmIOnM1KxKflOSFqSjyNMDF1GcEEvXnTgcuNsCpIjJWKW
 niOR5G1DS/jBzgtaJTmxCAL9ggnOP2L8/sX+p+IBcyqbfu0H5UuEWySk9UTtpq86VK/z
 +peA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhm7FdqPFGdBdvw4NGKr6pAnrEgBGBuZPTVSNrx7IN2G0rWbIu5y6ipSlbzEEqkc8bjolaXASfw3g=@lists.lttng.org
X-Gm-Message-State: AOJu0YxDOqzF/9sxCAFPSxkna5ZFpAl0bdIXUtA58pl9Il3xxtymMR4e
 d9sv/F6oP3YvTL42+BIoErWzgHMjrnA5sNA6NrWIlo/XiFYHyqJvgxFJo/01kARgj6q0OYqZ4mk
 44agsdKDdzFiFSWI5gutcMa4fJN4=
X-Gm-Gg: ASbGncslcm7RH4flpP3JDGvfZfLh33Jy+drp7hCRJXBTYaU+SPjkwBG861WZi6WyGf8
 2DiIMFddV2ucgEblzH0dtQpCK9oPFkWNabKAg2HXh/XfP7+cYfa55v5MfvglAgcVOQ/stNQ==
X-Google-Smtp-Source: AGHT+IFT/hHu3fmxLvLgR305Rg+L16JwZEFunrUGVghNE/+r/B/yMyaO+BHNJGk5lrGT0AxSmH3NQrC3bIzExbSP7QA=
X-Received: by 2002:a17:906:1bb1:b0:aa6:87e8:1d0e with SMTP id
 a640c23a62f3a-aa6c1b2a8a0mr446856566b.34.1734022626380; Thu, 12 Dec 2024
 08:57:06 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR01MB6845D1C81221547CEC94B3A782352@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
 <CAAS9dobC0wERGMQf9CLjhYY4ay_zSdAMAE9qxBezLtH-kL_1NQ@mail.gmail.com>
 <7f722802-752f-4cf5-ad2f-cb60264d8091@efficios.com>
 <VI1PR01MB684540CF33FFE72F69417E62823E2@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
 <8b3dc807-e512-4ea9-be7b-39abae58d886@efficios.com>
 <VI1PR01MB6845126CAEA7354042BA5E8B823F2@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
In-Reply-To: <VI1PR01MB6845126CAEA7354042BA5E8B823F2@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
Date: Thu, 12 Dec 2024 17:56:56 +0100
Message-ID: <CANVMif+3g=AitPhOcmg=dgoehkNm_m2U5qXW6UcOrPJ5CMDu6g@mail.gmail.com>
Subject: Re: [lttng-dev] Record stacktraces at userspace tracing domain
To: Alexander Krabler <Alexander.Krabler@kuka.com>
Content-Type: multipart/alternative; boundary="000000000000ad94340629159aee"
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
From: Dirk Eibach via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Dirk Eibach <dirk.eibach@googlemail.com>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000ad94340629159aee
Content-Type: text/plain; charset="UTF-8"

For more involved user space tracing I highly recommend
https://github.com/wolfpld/tracy

It is a different approach and probably already has all the bells and
whistles you require.

--000000000000ad94340629159aee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><p dir=3D"ltr">For more involved user space tracing =
I highly recommend=C2=A0<a href=3D"https://github.com/wolfpld/tracy">https:=
//github.com/wolfpld/tracy</a></p><p dir=3D"ltr">It is a different approach=
 and probably already has all the bells and whistles you require.</p>
</div></div>

--000000000000ad94340629159aee--
