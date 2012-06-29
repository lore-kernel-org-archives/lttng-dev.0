From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Re: Query about LTTng 2.0 Debian packages
Date: Thu, 28 Jun 2012 22:51:31 -0400
Message-ID: <CAEzWAeK+hFJr7xY_JF5MLH4YVfOHYq_OxgnLOsm7cUvUtsDjUA__1078.81527296758$1340938321$gmane$org@mail.gmail.com>
References: <20120621012622.GA1387@Krystal> <20120621191452.GA18195@quintessa>
	<20120629015815.GA22800@quintessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SkRJ3-0003mE-BZ
	for lttng-dev@lists.lttng.org; Thu, 28 Jun 2012 22:51:37 -0400
Received: by obbwd18 with SMTP id wd18so4965301obb.35
	for <lttng-dev@lists.lttng.org>; Thu, 28 Jun 2012 19:51:31 -0700 (PDT)
In-Reply-To: <20120629015815.GA22800@quintessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Thu, Jun 28, 2012 at 9:58 PM, Jon Bernard <jbernard@debian.org> wrote:
> * Jon Bernard <jbernard@debian.org> wrote:
>> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> > Hi Jon,
>> >
>> > I wanted to get in touch with you regarding LTTng 2.0 Debian packages.
>> > Is there anything we can do to help you getting those packages into
>> > Debian ? They have been out for a while now, and even Ubuntu picked th=
em
>> > up. I understand that you are probably busy, hence my offer for help.
>>
>> I've just uploaded another package I've been working on and LTTng 2.0 pa=
ckages
>> are next on my list. Give me a few days to get things sorted, I'll post =
an
>> update next week with my status.
>
> Is the 2.0 series indented to replace the existing UST, or should they be=
 able
> to exist side-by-side? =A0I'm inclined to think the new packages should r=
eplace
> the old ones, and thus prevent a user from having both installed at the s=
ame
> time, but wanted to check first.

Yes, the 2.0 should replace the old 0.x ones. The new lttng-ust
replace the old ust. Also you can replace the old lttctl with the new
lttng-tools.

> URCU is updated and I'm looking at UST/CTL now. I'll file ITPs for babelt=
race
> and modules in the morning.
>
> --
> Jon
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

Yannick Brosseau
yannickbrosseau.com
