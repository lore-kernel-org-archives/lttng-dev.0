From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: Bug in LTTng-UST
Date: Fri, 12 Dec 2014 23:21:23 -0500
Message-ID: <CAFXXi0nPMbLj-nAT281+7P=iUK+pg_PdMOP52XabquvVUikHSQ__47444.4474596114$1418444563$gmane$org@mail.gmail.com>
References: <1418432075.9766.6.camel@moya>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1XzeDO-0004lW-Q9
 for lttng-dev@lists.lttng.org; Fri, 12 Dec 2014 23:21:59 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so8115606iec.19
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 20:21:53 -0800 (PST)
In-Reply-To: <1418432075.9766.6.camel@moya>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Actually, I think the problem comes from UST not handling when a
program dlcloses a lib. There is a simpler way to show the problem.
Just have an app dlopen a .so that has a tracepoint and dlclose it.
When the app quits, UST will try to unregister the tracepoint and
read/write in the memory previously mapped to the library, causing a
segfault.

I have made a small example. You just need to click on "Download gist"
in [1] to download a tarball, and a then simple make should be enough.
Start a UST session with -u -a and run ./app. Segfault should ensue.

[1] https://gist.github.com/simark/9fc0e2395899fcd8d10d



On 12 December 2014 at 19:54, Matthew Khouzam
<matthew.khouzam@ericsson.com> wrote:
> Hi, it appears as though if a tracepoint is in a so, loading it,
> unloading it and reloading it makes it no longer visible.
>
> To confirm this you can try out this repo :
> https://github.com/TheMatthew/yquake2
> (I know, it's not a serious program... but the bug is serious, I think)
> You can get the demo files here
> http://www.fileplanet.com/6584/0/fileinfo/Quake-2-Demo-v3.14
> make the program (make from the git dir)
> copy the contents of the baseq2 in the demo into the release/baseq2
> directory
>
> start a ust session
> run the program.
> Ignore the baddr deadlocks :)
> The tracepoint is not visible, it is located in the game.so file.
>
> Chances are though that the problem is on my side, but the evidence
> (single registration ) seems to indicate that this is an actual problem.
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
