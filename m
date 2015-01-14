From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: c/c++ wrappers for lttng commands
Date: Wed, 14 Jan 2015 14:24:18 -0500
Message-ID: <CAFXXi0mntrDSz7j5CZKzm6o0KqU6hw1dF6E9HHEXyanYrHnsHA__5202.19691466099$1421263533$gmane$org@mail.gmail.com>
References: <CAM5kDqy6L5nSvs=GYwmXTgHSE+uH5p0d8YPYGeR-_E61mr4TqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1YBTYk-0002gk-M4
 for lttng-dev@lists.lttng.org; Wed, 14 Jan 2015 14:24:55 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so11233544iga.5
 for <lttng-dev@lists.lttng.org>; Wed, 14 Jan 2015 11:24:49 -0800 (PST)
In-Reply-To: <CAM5kDqy6L5nSvs=GYwmXTgHSE+uH5p0d8YPYGeR-_E61mr4TqA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 14 January 2015 at 14:02, Anand Neeli <anand.neeli@gmail.com> wrote:
> Hi All,
>
> Is there any code (or did anyone implement) c/c++ wrappers API's to
> create,delete, add event to lttng session.
> The conventional way to create, add event, delete lttng sessions is through
> lttng shell commands, i'm looking to do this using a c/c++ API's.
>
> Thanks,
> Anand Neeli

Hi Arnand,

I think you are looking for the liblttng-ctl library.

http://git.lttng.org/?p=lttng-tools.git;a=tree;f=src/lib/lttng-ctl;hb=HEAD

It is the library that the lttng command is based on, but you can also
use it in your program. I don't know if there is an official
documentation, but if you want to know how to do something using the
API, you can always look up the lttng command code and see what it
does.

It is in C, however. If you want to make an wrapper that is more C++
oriented, I am sure it would be a very appreciated contribution :).

Simon
