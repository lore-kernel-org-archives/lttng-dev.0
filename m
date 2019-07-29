From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: HugePages shared memory support in LLTng
Date: Mon, 29 Jul 2019 15:05:46 -0400
Message-ID: <20190729190546.GA29557__691.035196517475$1564427169$gmane$org@joraj-alpa>
References: <20190715143302.GA2017@joraj-alpa>
 <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
 <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ@mail.gmail.com>
 <20190722192308.GA803@joraj-alpa> <20190723150744.GC803@joraj-alpa>
 <CAO+PNdGhEgeTo35du4ysMcCOUQ0PKE4tuyGg593AE5feZZ4_JQ@mail.gmail.com>
 <20190723202723.GD803@joraj-alpa>
 <1962899258.11638.1564069223526.JavaMail.zimbra@efficios.com>
 <1564077561.2343.121.camel@impinj.com>
 <CAO+PNdGRD3BkfEOgjCLo+kgXreZD_GqYnW6LB7-ELjnowk+GjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45y8KX2sXzz1FxS
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 15:05:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAO+PNdGRD3BkfEOgjCLo+kgXreZD_GqYnW6LB7-ELjnowk+GjQ@mail.gmail.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> @Jonathan: This is my first time to get involved in an open-source
> project on the mailing list. I don't quite know how RFC works. Should
> I just do `git format-patch` and copy-paste the diff to an email? Is
> there any specific format for the RFC email and its title?

Copy paste to email is the way to go. You can also lookup "git send email" if you
want [1].

Make sure to have the following prefix in the email title: [RFC PATCH <project name>] Hugepages ...

<project name> would be either lttng-ust or lttng-tools for your patches.

Also make sure to give all the necessary details to test the patches and also the
pitfall/advantages you know regarding the use of hugepages. We do no expect the
patchset to be "integrated" into lttng (command line switch etc.) but one should
be able to take your patch and at least get a version of lttng working. Make
sure to indicate the current commit for each projects you are basing this work
on. As I said before, this is more a way of archiving the work you have done
then actively working on making lttng support hugepages.

[1] https://git-send-email.io

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
