From: Philippe Proulx <philippe.proulx@polymtl.ca>
Subject: Re: Java code for CTF trace writing?
Date: Mon, 15 Apr 2013 18:01:40 -0400
Message-ID: <CAB4xu_1zOHUD03dQ57DxKpQ1RWorocGK_0URCaxnohHB1FLEDw__49809.2266884216$1366063360$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f47.google.com ([209.85.215.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eeppeliteloop@gmail.com>) id 1URrTd-0006wH-Ji
	for lttng-dev@lists.lttng.org; Mon, 15 Apr 2013 18:02:17 -0400
Received: by mail-la0-f47.google.com with SMTP id eh20so3710593lab.6
	for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2013 15:02:11 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aaron Spear <aspear@vmware.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Linux Tools developer discussions <linuxtools-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

Actually, that was the exact purpose of my internship at Ericsson last summer.

I designed a new architecture for the CTF part of TMF, but it is still
not merged/integrated with mainline TMF (I don't even know if it's
still planned). See
<http://git.dorsal.polymtl.ca/~pproulx?p=javeltrace.git;a=summary>.

This new architecture is able to read _and write_ CTF packets in a
generic way. The "Javeltrace" name is just a portmanteau of Java and
Babeltrace, although should this refined library be integrated into
TMF, it's not planned to be named like this. However, there exist a
command-line tool that I made which is officially named Javeltrace and
uses the aforementioned library. It is described here:
<http://www.dorsal.polymtl.ca/~pproulx/javeltrace/>. As explained on
the webpage, the main goal of this utility is to test my work
interactively.

Keep in mind that everything mentioned here is not thoroughly tested
and for sure there are a few bugs remaining. Also, the code didn't
evolve with the latest CTF versions, so there must be incompatibility
at some level.

The main use case at Ericsson was to synthesize a precise fake trace
from scratch using a human readable input format that could be
versioned. The generated CTF traces would then be used to exercise
parts of TMF to test specific behaviours without having to produce an
actual real trace. After a few discussions, we chose JSON as an
interchange format. So you will see lots of JSON related code out
there. The command-line Javeltrace utility is able to translate
from/to binary CTF.

At the end of my internship, I started writing docs for what I did.
It's here: <http://wiki.eclipse.org/Linux_Tools_Project/TMF/CTF_guide>.
It's not finished, but almost, so it should be up-to-date with my Git
codebase.

I also made this as a proof of concept:
<http://git.dorsal.polymtl.ca/~pproulx?p=javeltrace.git;a=tree;f=lttng/org.eclipse.linuxtools.ctf.core/src/org/eclipse/linuxtools/ctf/core/trace/out;h=67ab3097e9f3fc52a685d29620e4c40ee26ee896;hb=47b4cef68eb4524fc9e1865f58474e0bc81eba77>
(see all Mug*.java files). MugTracer is a simple Java tracer that
produces native CTF without even using the rest of my library since
CTF is so easy to *write*. It has a consumer thread and worked well,
although I didn't run any benchmark and I believe it's really slow
compared to UST.

Feel free to contact me, should you have any question about this.

On 15 April 2013 17:14, Aaron Spear <aspear@vmware.com> wrote:
> Hi all,
>
> I was wondering if anyone knew of some open source Java library that could WRITE CTF traces? I am using the linuxtools/TMF plugins to read CTF traces, but now need to write them from Java as well.
>
> I have a use case where I have an "event bus" in the Java app world and I would like to persist this event stream as a CTF trace. In this particular use case, the speed/low intrusiveness of LTTng UST is not as important as the portability, so a pure Java solution is ideal, though not strictly required.
>
> Also, please let me know if there are others out there who are interested in collaborating in writing such a library.
>
> regards,
> Aaron Spear
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
