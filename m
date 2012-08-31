From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Questions about CTF format
Date: Fri, 31 Aug 2012 10:34:48 -0400
Message-ID: <5040CB88.3090203__11918.291290249$1346423747$gmane$org@ericsson.com>
References: <CAEBwSh_OkCZiWJXQrUO3fnLnka3MfTJpa8z0HqxxVFd7CtPqOg@mail.gmail.com>
	<20120705142052.GA23162@Krystal>
	<CAEBwSh8vqVr9LsPPRxx_c9da7M3spcMwrHTkSX+bWE1_UQVXbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0708983343=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1T7SJP-0007cM-QQ
	for lttng-dev@lists.lttng.org; Fri, 31 Aug 2012 10:35:07 -0400
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q7VEaxCu028080
	for <lttng-dev@lists.lttng.org>; Fri, 31 Aug 2012 09:37:22 -0500
In-Reply-To: <CAEBwSh8vqVr9LsPPRxx_c9da7M3spcMwrHTkSX+bWE1_UQVXbw@mail.gmail.com>
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

--===============0708983343==
Content-Type: multipart/alternative;
	boundary="------------090809070400030407050207"

--------------090809070400030407050207
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit


On 12-07-05 10:49 AM, Diego Dompe wrote:
> Hi Mathieu,
>
> Thanks for the help. Here is my list of details:
>
> - Clocks: the spec doesn't explain properly that timestamps are an
> offset from the base time of the clock they refer to. Since I was
> using 64bit timestamps I somehow assumed that I was using absolute
> timestamps from the epoch (although the spec doesn't says it either).
This is acceptable AFAIK, just to be clear, you can use arbitrary time
origins, that means epoch is a valid origin too. You can also use a
scaling factor, just be careful applying it since a double has 53 bits
and thus you may lose precision.
>
> - I saw that the lttng-generated traces for metadata are always a
> multiple of 4k in size (at least the ones I generate for either kernel
> or user space). I can't find where in the spec it mentions
> requirements regarding metadata packet padding. I was generating
> metadata packets that ended up right after my TSDL and eclipse wasn't
> happy about it (although I didn't try babeltrace).
Could you send the trace please, I can look into it.

> Also I found that the lttng-generated traces have a "empty" metadata
> packet after the metadata containing the TSDL, I didn't find either
> any documentation regarding this.
>
> Regards,
>
> Diego
>
> On Thu, Jul 5, 2012 at 8:20 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com
> <mailto:mathieu.desnoyers@efficios.com>> wrote:
>
>     * Diego Dompe (ddompe@gmail.com <mailto:ddompe@gmail.com>) wrote:
>     > Hi,
>     >
>     > I'm developing a custom tracer for an embedded product that will
>     generate
>     > CTF format. I was able to generate generic traces that can be
>     interpreted
>     > properly with babeltrace (but not with eclipse, I already file a
>     bug for
>     > that), but I found the CTF specification lacking in some aspects
>     (I had to
>     > peek into lttng-generated CTF traces to figure out some
>     details). I was
>     > wondering what is the proper mailing list to clear my questions
>     and provide
>     > feedback on the CTF specification for improvement in the areas
>     where the
>     > documentation is not detailed yet. I don't see any CTF-specific
>     mailing
>     > list, it's OK to discuss it here? Or maybe directly with a
>     developer(s)?
>
>     Hi Diego,
>
>     Yes, this mailing list would be the proper place, along maybe with
>     adding the MCA tiwg mailing list in CC, which I'm doing here.
>
>     Thanks,
>
>     Mathieu
>
>     --
>     Mathieu Desnoyers
>     Operating System Efficiency R&D Consultant
>     EfficiOS Inc.
>     http://www.efficios.com
>
>


--------------090809070400030407050207
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix">On 12-07-05 10:49 AM, Diego Dompe
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAEBwSh8vqVr9LsPPRxx_c9da7M3spcMwrHTkSX+bWE1_UQVXbw@mail.gmail.com"
      type="cite">Hi Mathieu,
      <div><br>
      </div>
      <div>Thanks for the help. Here is my list of details:</div>
      <div><br>
      </div>
      <div>- Clocks: the spec doesn't explain properly that timestamps
        are an offset from the base time of the clock they refer to.
        Since I was using 64bit timestamps I somehow assumed that I was
        using absolute timestamps from the epoch (although the spec
        doesn't says it either).</div>
    </blockquote>
    This is acceptable AFAIK, just to be clear, you can use arbitrary
    time origins, that means epoch is a valid origin too. You can also
    use a scaling factor, just be careful applying it since a double has
    53 bits and thus you may lose precision.<br>
    <blockquote
cite="mid:CAEBwSh8vqVr9LsPPRxx_c9da7M3spcMwrHTkSX+bWE1_UQVXbw@mail.gmail.com"
      type="cite">
      <div><br>
      </div>
      <div>- I saw that the lttng-generated traces for metadata are
        always a multiple of 4k in size (at least the ones I generate
        for either kernel or user space). I can't find where in the spec
        it mentions requirements regarding metadata packet padding. I
        was generating metadata packets that ended up right after my
        TSDL and eclipse wasn't happy about it (although I didn't try
        babeltrace). </div>
    </blockquote>
    Could you send the trace please, I can look into it. <br>
    <br>
    <blockquote
cite="mid:CAEBwSh8vqVr9LsPPRxx_c9da7M3spcMwrHTkSX+bWE1_UQVXbw@mail.gmail.com"
      type="cite">
      <div>Also I found that the lttng-generated traces have a "empty"
        metadata packet after the metadata containing the TSDL, I didn't
        find either any documentation regarding this.</div>
      <div><br>
      </div>
      <div>Regards,</div>
      <div><br>
      </div>
      <div>Diego</div>
      <div><br>
      </div>
      <div>
        <div class="gmail_quote">On Thu, Jul 5, 2012 at 8:20 AM, Mathieu
          Desnoyers <span dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:mathieu.desnoyers@efficios.com"
              target="_blank">mathieu.desnoyers@efficios.com</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div class="HOEnZb">
              <div class="h5">* Diego Dompe (<a moz-do-not-send="true"
                  href="mailto:ddompe@gmail.com">ddompe@gmail.com</a>)
                wrote:<br>
                &gt; Hi,<br>
                &gt;<br>
                &gt; I'm developing a custom tracer for an embedded
                product that will generate<br>
                &gt; CTF format. I was able to generate generic traces
                that can be interpreted<br>
                &gt; properly with babeltrace (but not with eclipse, I
                already file a bug for<br>
                &gt; that), but I found the CTF specification lacking in
                some aspects (I had to<br>
                &gt; peek into lttng-generated CTF traces to figure out
                some details). I was<br>
                &gt; wondering what is the proper mailing list to clear
                my questions and provide<br>
                &gt; feedback on the CTF specification for improvement
                in the areas where the<br>
                &gt; documentation is not detailed yet. I don't see any
                CTF-specific mailing<br>
                &gt; list, it's OK to discuss it here? Or maybe directly
                with a developer(s)?<br>
                <br>
              </div>
            </div>
            Hi Diego,<br>
            <br>
            Yes, this mailing list would be the proper place, along
            maybe with<br>
            adding the MCA tiwg mailing list in CC, which I'm doing
            here.<br>
            <br>
            Thanks,<br>
            <br>
            Mathieu<br>
            <span class="HOEnZb"><font color="#888888"><br>
                --<br>
                Mathieu Desnoyers<br>
                Operating System Efficiency R&amp;D Consultant<br>
                EfficiOS Inc.<br>
                <a moz-do-not-send="true" href="http://www.efficios.com"
                  target="_blank">http://www.efficios.com</a><br>
              </font></span></blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------090809070400030407050207--


--===============0708983343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0708983343==--
