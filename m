Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EBED41D64
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Dec 2025 15:52:07 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1765468326; x=1765475526;
 h=Sender: Sender: Cc: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: Content-Type: To: To: Subject: Subject: Message-ID: Date: In-Reply-To: References: MIME-Version;
 bh=kJmTKz6JPil/PKDQ9CMsVnoUT0nRBdACic6NnrUwuH4=;
 b=YOlRz3hgHrnEVAnmzIf7m8cVRzuPFMrKOTRJOMpJaydPDvGMFu5kK64pH6hm4BmrTOIw0uI62d/YiiSJASkt0oPt5Rs0s8LwR5sEmmGxpSOad0Lv24SVMrD5VAB5VFxFodrF0bYgGgyw895YAEh4bqSZvh8VjDGSn7D9Bq38nBP1VHU9Z8RMWV5GM/47jM2dwuvPjn765bVY5iqieUwZO5AemE9oDKl1hgnkvtdy4cEcaHv4VBI1Hdl/BexSrvgggJkx3sHNBrhruBHKlYSUtLG+hRjZTetgOYboOuVEDnE4qg3W98OTxHmXrcv32vTMVKsIM//02hxHq0CYW3tGLQ==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 cd757e2fd5dc5367e95ae9836700ea7117a2d003b3a24a9258f25e3cd713f937 with SMTP id
 693ae8a60b2e34eaf1ae6292 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 11 Dec 2025 15:52:06 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRxsx3N4tz1wgM
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1765468326;
	b=PkACyf+m7LqM8/VI/J0wd3Do5IqRIoNFZ6C6yHGVhJvyYZanDAxtVaXXGUO+RLg6OH2f
	 Tx3LABZw/R43Rt/dHN3siiCvjTwZ0ahryJJhrCu/H7o1JJdFuaZO0y4EOy7PTKLxN1o9x
	 9D2SJ6xILNQHC9z/iuoLhQawJPMUJgoWBz4DeH8IqyakXeW7K9DNrQuCVZxv2CRQXX4lo
	 SE6hdjZLHa6eLaM+6BP8TbZAKDMG1sfZQrgk7P858+8F257aKB8ywm9FR6ydEspuN1Gc9
	 zEvvwjw59dip+3R0aGRUZxJQqR8srntz7kqY9a8LcAAMb0Bqd0D+3Zus0K4mt0dF3dA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1765468326;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=PsboBVm+q1aVBO/WzDmo9zFQCvzDg0EwuHMzk5CgLqM=;
	b=FJWcrNygOeVocoGWL2fA8wm0BiS8jzjKV5WNMOgLO69tbuGP4YwMECri39rS4V7/Sq/O
	 tgcFBsRmF9rY7Bjf0igbjDZS7FHpKxiOOxiQKDTnO4+2Wdm3Zx4Ocssd0eJurHGJvEw+J
	 IGQ7OwqE2lLDY/ge7brjUBsrwqddeoQzqaK4ftBwWUQene3FYD3LPZgAbQJOBfQRtUyEL
	 4XDGfco+X5I0CmohUbO/WzEG+ey/k90FN+5W7RlJKhXa5ypH06Nomc4KiPE8Ja3xh6HtP
	 f4J3VXtozsSIoVYMFNXeUWXAgO6+Z6hucFxBC+DZLBoZr3ZqSToo2GDwWDJ2NGyn39A==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRxsx3N4tz1wgM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1765468326;
	bh=PsboBVm+q1aVBO/WzDmo9zFQCvzDg0EwuHMzk5CgLqM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=yQcOq8BNZ/AAyGXAe7R3+10bBvxogl5Hp/+c6WApxy/JABDxuKUP60eY88g9g0YRx
	 MPpvbKEf33O/aZkEx1EpkY1xoU53JQreDq+wAQTxBBh1e7wDUoF82c4aBWGEy4SY0d
	 NvBXzhpBAnj4gKv5+RqFrDounouiaqbIfUt13kAzgFt8YSXdzRhHQOHniKz+Rtf8d7
	 7VMQ4HooPNG4hyudyFLPgZKI39vCpwJ45Ww1pA0IaB0+ROiuXIh7+qjNawOFXm72K4
	 7U1p2oTZdG3sty31Y+/uQ7VMqa5p6uHjq8z+/4E2Mr/qDdvo0uCJrkNq1ZyC1OmdJJ
	 6pw8dl8lo0+og==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dRxsx3N4tz1wgM;
	Thu, 11 Dec 2025 10:52:05 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRxsw4GGkz1wLB
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRxsw4GGkz1wLB
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by lists.lttng.org (Postfix) with ESMTPS id 4dRxsw4GGkz1wLB
 for <lttng-dev@lists.lttng.org>; Thu, 11 Dec 2025 10:52:04 -0500 (EST)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65745a436f7so134873eaf.3
 for <lttng-dev@lists.lttng.org>; Thu, 11 Dec 2025 07:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765468323; x=1766073123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJmTKz6JPil/PKDQ9CMsVnoUT0nRBdACic6NnrUwuH4=;
 b=lzlOq/9IuKHPZBn3YNtjE/G6WnXTqLziohDhqePmp038SjuC8ouJvEWT+i6Uq6v7a9
 qvHfMHBLjuAj0jJKShnuyYZCmTUjLwKqtsOHbx9WLZv6JXumvS+k5d2l2NKpAIyeoPoJ
 rH5nSB9K5jWK0HpPpgyoNkrIa0P1ShF/UoMTubNgxn9hKrdjP7LsSfRZDuXI59Bs/Gak
 M8GYRC8HRcih3jCnI8RPlR78gURK9BIbLPEdR8f4x4OGsCkXbZNBUhpQDBXUIx7X7VOX
 J2VmuzmUaxE6pjpiMh6p2JXMg9TtzW0B076BGMuPSqlg/kq5TFHx4j/Aq9GWydMNVT9Z
 H8lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKGvf0oBw7QVz0OMKJ/tZWCra44V6H4LelHrmKeptUjUDkKLJXQhWpZxACPtSu8b40asE1rMpi3LU=@lists.lttng.org
X-Gm-Message-State: AOJu0Yx6Pthjhzv9NnJwzqNS6hnFWSqnjzsnZ5Gf5rmmGnYYRbNsPn8P
 gf/0OnSkv1zOHVQNy8bCJ68l8RkRNlak94OVibuGuxDhKzwU6Lu4t3ubGgd0QQlEbAein1wBAXL
 w+ZznXZ3608zo/JIdRnnRhts0ppy6Xq2wtRCgW0usRg==
X-Gm-Gg: AY/fxX5HRXEVhwBr3Eeq3w2x8doQj2AoKHP+JTJ8MGck56jShn6/eTcHjKav/LqR/mi
 9OKjPM3sgFp/foPSk+8kyGRDxcFEe9plPhAa6V0WwHYK/PWs+cDdJojrzlj9n9rRdBS4yums+/g
 ViU/s1Lg18b2zvWN5EDcM1/autHfBm6E0svsQMnkk3iPUBXspxrks9aTFL6/HPuPuKJPNbNVdCP
 +CoSDBeFxsX+wCO9Pg+sOXlnpuhPViqlW/8uZSJq8tsZCTMWeXoaOyTQQIJ+9t/4hVqth0dis8w
 BSJAc5B9xKEA4wJTAEYfKk7MdvOureTN90AsfA==
X-Google-Smtp-Source: AGHT+IHPZ0cdemRUDw0ZwLEbhiiSEZfIe85gFCY24U6WOy0Z4IaLRPoB/0lA6lsHLAEYA0FLMaNX7yWoTGY94vwPRHU=
X-Received: by 2002:a05:6820:f48:b0:659:9a49:8f8a with SMTP id
 006d021491bc7-65b2ad07bccmr3286911eaf.79.1765468322927; Thu, 11 Dec 2025
 07:52:02 -0800 (PST)
MIME-Version: 1.0
References: <CAOQX81f1zGCsnr3Ksjv0WoO-J4-OULanefNxzWdrxP8b4+aqJg@mail.gmail.com>
 <87a7e3d3-3ce2-4ded-acdf-bc7f152cdcec@efficios.com>
 <073db198-6792-4caa-81f5-ac65f5d76f1e@efficios.com>
In-Reply-To: <073db198-6792-4caa-81f5-ac65f5d76f1e@efficios.com>
Date: Thu, 11 Dec 2025 10:51:50 -0500
X-Gm-Features: AQt7F2qBuf-LfZxkPQ0YPaEWkjE7fX97UAtAlx68PAsgBj41r1LgoqstnWUYM6k
Message-ID: <CAOQX81e-dtfgLQ+xTt8kr-Qxc+hhiaW4vHF=S=RDVsMR0-TnLA@mail.gmail.com>
Subject: Re: Question about LTTng Context
To: Michael Jeanson <mjeanson@efficios.com>
Content-Type: multipart/alternative; boundary="0000000000004025e40645af20ad"
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
From: Amir Najafi Zadeh via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Amir Najafi Zadeh <anajafizadeh@cs.stonybrook.edu>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--0000000000004025e40645af20ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Michael, Kienan, Thank you both for your replies. As you mentioned the
cgroup namespace, it isn=E2=80=99t very helpful in some cases. Containers m=
ay share
the same cgroup namespace, and the container runtime often avoids giving
each container a private cgroup namespace for performance and security
reasons. Because of this, the cgroup namespace can=E2=80=99t be used as a r=
eliable
or unique label for filtering trace logs.

In my case, with container-d you can inspect a container, find its PID, and
then check /proc/<pid>/ns/cgroup, but you=E2=80=99ll see that different con=
tainers
often have the same cgroup namespace ID (e.g., in the following logs you
can see the calico-node and kube-proxy containers sharing a cgroup ns).

```
Name: calico-node  CID:
b5624afe31b005725f4ba53c7b6fe758f3c09fabf013085231ff8b97588f6ace  PID: 2243
 cgroup_ns_inode: 4026531835
Name: kube-proxy  CID:
52f3c12def7a680f61a925ac92dd5ebd5eba6cad17d671efbfd1d40db7dff624  PID: 1851
 cgroup_ns_inode: 4026531835
  >> MATCH FOUND: shares ns with container:
b5624afe31b005725f4ba53c7b6fe758f3c09fabf013085231ff8b97588f6ace
(calico-node)
```

Thanks again for your answers. I hope this feature appears in a future
patch.

Best,
Amir

On Thu, Dec 11, 2025 at 9:57=E2=80=AFAM Michael Jeanson <mjeanson@efficios.=
com>
wrote:

> On 12/11/25 09:30, Kienan Stewart via lttng-dev wrote:
> > Hi Amir,
> >
> > On 12/10/25 9:40 PM, Amir Najafi Zadeh via lttng-dev wrote:
> >> Hello everyone,
> >>
> >> I hope you=E2=80=99re doing well. My name is Amir, and I=E2=80=99m a P=
hD student in
> >> the Computer Science department at Stony Brook University, New York.
> >>
> >> I have a question about the LTTng context that I haven=E2=80=99t been =
able to
> >> find an answer for in the docs or man pages. Does LTTng support adding
> >> the cgroup ID or cgroup path as a context field? I want to filter my
> >> trace results based on cgroups.
> >>
> >
> > I think you're looking for the `cgroup_ns` context which adds the inum
> > of the cgroup namespace as a context field.
>
> This will give you the ID of the cgroup namespace but we don't have
> contexts for cgroups themselves. It's probably something we would like
> to have but there is no concrete plans on implementing this at the moment=
.
>
> >
> >> If this isn=E2=80=99t supported, are there any plans to add it in futu=
re
> >> versions, such as 2.14?
> >>
> >> For reference, I=E2=80=99m currently using LTTng 2.13 on Ubuntu 24.04 =
with
> >> kernel 6.8.0-87-generic.
> >>
> >> Cheers,
> >> Amir
> >> --
> >> *Amirhossein Najafizadeh*
> >> *PhD Student, Computer Science Department, Stony Brook University, N.Y=
.
> >> File systems and Storage Lab (FSL)
>

--0000000000004025e40645af20ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Michael, Kienan, Thank you both for your replies. As you m=
entioned the cgroup namespace, it isn=E2=80=99t very helpful in some cases.=
 Containers may share the same cgroup namespace, and the container runtime =
often avoids giving each container a private cgroup namespace for performan=
ce and security reasons. Because of this, the cgroup namespace can=E2=80=99=
t be used as a reliable or unique label for filtering trace logs.<br><br>In=
 my case, with container-d you can inspect a container, find its PID, and t=
hen check /proc/&lt;pid&gt;/ns/cgroup, but you=E2=80=99ll see that differen=
t containers often have the same cgroup namespace ID (e.g., in the followin=
g logs you can see the calico-node and kube-proxy containers sharing a cgro=
up ns).<br><br>```<br>Name: calico-node =C2=A0CID: b5624afe31b005725f4ba53c=
7b6fe758f3c09fabf013085231ff8b97588f6ace =C2=A0PID: 2243 =C2=A0cgroup_ns_in=
ode: 4026531835<br>Name: kube-proxy =C2=A0CID: 52f3c12def7a680f61a925ac92dd=
5ebd5eba6cad17d671efbfd1d40db7dff624 =C2=A0PID: 1851 =C2=A0cgroup_ns_inode:=
 4026531835<br>=C2=A0 &gt;&gt; MATCH FOUND: shares ns with container: b5624=
afe31b005725f4ba53c7b6fe758f3c09fabf013085231ff8b97588f6ace (calico-node)<b=
r>```<br><br>Thanks again for your answers. I hope this feature appears in =
a future patch.<br><br>Best,<br>Amir</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 11, 2=
025 at 9:57=E2=80=AFAM Michael Jeanson &lt;<a href=3D"mailto:mjeanson@effic=
ios.com">mjeanson@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 12/11/25 09:30, Kienan Stewart via lttng-d=
ev wrote:<br>
&gt; Hi Amir,<br>
&gt; <br>
&gt; On 12/10/25 9:40 PM, Amir Najafi Zadeh via lttng-dev wrote:<br>
&gt;&gt; Hello everyone,<br>
&gt;&gt;<br>
&gt;&gt; I hope you=E2=80=99re doing well. My name is Amir, and I=E2=80=99m=
 a PhD student in <br>
&gt;&gt; the Computer Science department at Stony Brook University, New Yor=
k.<br>
&gt;&gt;<br>
&gt;&gt; I have a question about the LTTng context that I haven=E2=80=99t b=
een able to <br>
&gt;&gt; find an answer for in the docs or man pages. Does LTTng support ad=
ding <br>
&gt;&gt; the cgroup ID or cgroup path as a context field? I want to filter =
my <br>
&gt;&gt; trace results based on cgroups.<br>
&gt;&gt;<br>
&gt; <br>
&gt; I think you&#39;re looking for the `cgroup_ns` context which adds the =
inum <br>
&gt; of the cgroup namespace as a context field.<br>
<br>
This will give you the ID of the cgroup namespace but we don&#39;t have <br=
>
contexts for cgroups themselves. It&#39;s probably something we would like =
<br>
to have but there is no concrete plans on implementing this at the moment.<=
br>
<br>
&gt; <br>
&gt;&gt; If this isn=E2=80=99t supported, are there any plans to add it in =
future <br>
&gt;&gt; versions, such as 2.14?<br>
&gt;&gt;<br>
&gt;&gt; For reference, I=E2=80=99m currently using LTTng 2.13 on Ubuntu 24=
.04 with <br>
&gt;&gt; kernel 6.8.0-87-generic.<br>
&gt;&gt;<br>
&gt;&gt; Cheers,<br>
&gt;&gt; Amir<br>
&gt;&gt; -- <br>
&gt;&gt; *Amirhossein Najafizadeh*<br>
&gt;&gt; *PhD Student, Computer Science Department, Stony Brook University,=
 N.Y.<br>
&gt;&gt; File systems and Storage Lab (FSL)<br>
</blockquote></div>

--0000000000004025e40645af20ad--
