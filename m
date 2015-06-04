From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: confirm c4ffe9cce5044a3711020b355aa9133ec1268447
Date: Wed, 3 Jun 2015 23:18:01 -0400
Message-ID: <CAB4xu_1vPZ7Yxi_=OFkn-dsbfR-H9yH-Er8P4cRasoR-TUMRrA__26868.5295632624$1433387966$gmane$org@mail.gmail.com>
References: <mailman.0.1433384331.3379.lttng-dev@lists.lttng.org>
 <CAG6yzexQjo2856DcndLzsQ9UU0OL81MYUBSMAgBHTPJehux46A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f42.google.com ([209.85.215.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Z0Lfv-0001Dr-JY
 for lttng-dev@lists.lttng.org; Wed, 03 Jun 2015 23:18:36 -0400
Received: by labpy14 with SMTP id py14so22306899lab.0
 for <lttng-dev@lists.lttng.org>; Wed, 03 Jun 2015 20:18:32 -0700 (PDT)
In-Reply-To: <CAG6yzexQjo2856DcndLzsQ9UU0OL81MYUBSMAgBHTPJehux46A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Deepak Kumar <dekumar1976@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Jun 3, 2015 at 10:22 PM, Deepak Kumar <dekumar1976@gmail.com> wrote:
> Hi,
>
> I am trying to output the inpute lttng live stream to ctf-metadata and still
> it shows as text.
> I tried ctf and dummy also. Am I using the command wrong?

You're not using it wrong; the Babeltrace tool does not currently honor its
own semantics: the lttng-live "plugin" uses the ctf-text "plugin" directly,
bypassing any generic event stream phase.

I write "plugin" in quote here because the current "plugin" system is
too primitive
for "plugins" to be called plugins without quotes. But there's active work being
done right now to implement a robust plugin system, as generic as you can think,
and this kind of operation will be easy once it's completed.

In the meantime, stay tuned (here)!

BR,
Phil

>
> babeltrace -o ctf-metadata -i lttng-live
> net://localho/host/dekumar-VirtualBox/auto-20150603-183122
>
>
> Thanks,
> Deepak
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
