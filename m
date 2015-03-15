From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: how to generate CTF metadata
Date: Sun, 15 Mar 2015 17:31:06 -0400
Message-ID: <CAB4xu_3e6C-1ELJH-M-otbpqXzh9QeN_=8-t0guzLSiA9F8DNw__31599.8901184232$1426455150$gmane$org@mail.gmail.com>
References: <5505F8D7.7060509@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1YXG8M-00024N-Tn
 for lttng-dev@lists.lttng.org; Sun, 15 Mar 2015 17:31:43 -0400
Received: by lbbsy1 with SMTP id sy1so19915936lbb.1
 for <lttng-dev@lists.lttng.org>; Sun, 15 Mar 2015 14:31:37 -0700 (PDT)
In-Reply-To: <5505F8D7.7060509@seznam.cz>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dominik Taborsky <bremby@seznam.cz>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sun, Mar 15, 2015 at 5:25 PM, Dominik Taborsky <bremby@seznam.cz> wrote:
> Hello,
>
> I am working on a project that involves generating CTF metadata, but I am
> unsure about how to proceed. I am not sure about how to get information
> about types,

What "types" are you talking about exactly? What are you intending to
write to binary streams?

Phil

> i.e. their size, signedness, alignment and possibly other. I
> know this information can be gathered from DWARF. Is that the primary way to
> do this? Is there any other, reasonable way? Can you point me at some code
> that does this? How does the LTTng linux kernel module work?
>
> Thanks.
>
> Dominik
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
