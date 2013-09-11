From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Getting function names with	lttng-ust-cyg-profile.so
Date: Wed, 11 Sep 2013 14:24:29 +0200
Message-ID: <523060FD.9020504__33449.9380006038$1378902346$gmane$org@mentor.com>
References: <522E4FCE.7070000@voxpopuli.im>
	<20130909234409.GA11082@Krystal>	<522EC38B.6000501@mentor.com>
	<522F3CC1.5060005@ericsson.com> <522F3E95.7000203@mentor.com>
	<OFD1B4818C.1C2E4DBC-ONC2257BE3.002FD513-C2257BE3.00328DCA@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1960706881=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VJjTK-0007mk-Ny
	for lttng-dev@lists.lttng.org; Wed, 11 Sep 2013 08:24:46 -0400
In-Reply-To: <OFD1B4818C.1C2E4DBC-ONC2257BE3.002FD513-C2257BE3.00328DCA@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1960706881==
Content-Type: multipart/alternative;
	boundary="------------030500020709040500010606"

--------------030500020709040500010606
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 09/11/2013 11:12 AM, Amit Margalit wrote:
> I agree with Paul, that no redundant data gets replicated with his
> approach, and my only concern is that this approach really forces a
> viewer to be sequential.
>
> Maybe "forces" is too strong a word - but a viewer than wants to let
> you "roam" the trace freely will have to read the entire trace to
> figure out the mapping between address and symbol at each point in time.
>
> At this time, we keep 10GB worth of LTTng traces in our system, but
> future models will certainly use more. A user asking to go to the end
> of the trace will have to wait until the entire trace is read in order
> to see correct translations.

We could provide a solution to this problem with my approach by emitting
an update of the shared object state info every n x K events (configurable).

Assuming we have a 10GB trace data set, we could emit a full shared
object state dump after every 100K events of regular trace data (with
the same baddr_init events we emit at session_start time). By doing so
you don't need to start reading the entire trace from the beginning.
Just start reading 100K events before the events you are interested in,
and you can guarantee to find a "key frame" for shared object state info.

Note that this is the same concept as used by video compression/streaming:
I-frame, P-frame, P-frame, P-frame, ..., I-frame, P-frame, P-frame,
P-frame, ...*
*See: http://en.wikipedia.org/wiki/Video_compression_picture_types

Best,
Paul*
**
*
> *
> **I have a different solution, which I think I have explained here
> before:
> **_http://lists.lttng.org/pipermail/lttng-dev/2013-August/021263.html_******
> * *
> **I vote for adding this to the metadata. It can be in addition to the
> ust_baddr events suggeted by Paul.****
> * *
> **Amit****
> * *
> **Amit Margalit****
> **IBM XIV **- /Storage Reinvented/****
> **XIV-NAS Development Team****
> **Tel. 03**-689-7774****
> **Fax. 03-689-7230****
> * *
> * *
> * *
> **From:        **"Woegerer, Paul" <Paul_Woegerer@mentor.com>****
> **To:        **Matthew Khouzam <matthew.khouzam@ericsson.com>****
> **Cc:        **lttng-dev <lttng-dev@lists.lttng.org>, Mathieu
> Desnoyers <mathieu.desnoyers@efficios.com>****
> **Date:        **09/10/2013 06:47 PM****
> **Subject:        **Re: [lttng-dev] Getting function names with      
>  lttng-ust-cyg-profile.so****
> *
> ------------------------------------------------------------------------
> *
> * *
> * *
> **On 09/10/2013 05:37 PM, Matthew Khouzam wrote:
> > On 13-09-10 03:00 AM, Woegerer, Paul wrote:
> >> Hi Alexandre,
> >>
> >> For trivial examples you can go with 'nm -CS' (or the like), but when
> >> you start to use liblttng-ust-cyg-profile.so in combination with shared
> >> objects you will need to record base address information as well (to
> >> allow you map a virtual memory address at a given point in time to
> >> offset and path of a shared object (or executable)).
> >>
> >> That is one of the reasons why I have submitted:
> >> **http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html**
> > This is a very interesting approach, +1 from me on that.
>
> Thanks.
>
> With that approach no redundant data (that is already available as
> debuginfo) gets replicated in the actual trace data.
> Only the bare minimum of information gets traced to allow you at any
> time to map a VM address to a debuginfo address + debuginfo location.
>
> -- 
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <**http://go.mentor.com/sourceryanalyzer**>
> Mentor Graphics, Embedded Software Division
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> **http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev**
>
> * *
> * 
*
**
*

-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division


--------------030500020709040500010606
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 09/11/2013 11:12 AM, Amit Margalit
      wrote:<br>
    </div>
    <blockquote
cite="mid:OFD1B4818C.1C2E4DBC-ONC2257BE3.002FD513-C2257BE3.00328DCA@il.ibm.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <font size="2" face="sans-serif">I agree with Paul, that no
        redundant data
        gets replicated with his approach, and my only concern is that
        this approach
        really forces a viewer to be sequential.</font>
      <br>
      <br>
      <font size="2" face="sans-serif">Maybe "forces" is too strong
        a word - but a viewer than wants to let you "roam" the trace
        freely will have to read the entire trace to figure out the
        mapping between
        address and symbol at each point in time.</font>
      <br>
      <br>
      <font size="2" face="sans-serif">At this time, we keep 10GB worth
        of
        LTTng traces in our system, but future models will certainly use
        more.
        A user asking to go to the end of the trace will have to wait
        until the
        entire trace is read in order to see correct translations.</font>
      <br>
    </blockquote>
    <br>
    We could provide a solution to this problem with my approach by
    emitting an update of the shared object state info every n x K
    events (configurable).<br>
    <br>
    Assuming we have a 10GB trace data set, we could emit a full shared
    object state dump after every 100K events of regular trace data
    (with the same baddr_init events we emit at session_start time). By
    doing so you don't need to start reading the entire trace from the
    beginning. Just start reading 100K events before the events you are
    interested in, and you can guarantee to find a "key frame" for
    shared object state info.<br>
    <br>
    Note that this is the same concept as used by video
    compression/streaming:<br>
    I&#8209;frame, P&#8209;frame, P&#8209;frame, P&#8209;frame, ..., I&#8209;frame, P&#8209;frame, P&#8209;frame,
    P&#8209;frame, ...<b><br>
    </b>See:
    <a class="moz-txt-link-freetext" href="http://en.wikipedia.org/wiki/Video_compression_picture_types">http://en.wikipedia.org/wiki/Video_compression_picture_types</a><br>
    <br>
    Best,<br>
    Paul<b><br>
    </b><b><br>
    </b>
    <blockquote
cite="mid:OFD1B4818C.1C2E4DBC-ONC2257BE3.002FD513-C2257BE3.00328DCA@il.ibm.com"
      type="cite">
      <b><br>
      </b><b><font size="2" face="sans-serif">I have a different
          solution, which I
          think I have explained here before: </font></b><b><a
          moz-do-not-send="true"
href="http://lists.lttng.org/pipermail/lttng-dev/2013-August/021263.html"><font
            size="3" color="blue"><u>http://lists.lttng.org/pipermail/lttng-dev/2013-August/021263.html</u></font></a></b><b><font
          size="3">
        </font></b><b>
      </b><b><br>
      </b>
      <b><br>
      </b><b><font size="2" face="sans-serif">I vote for adding this to
          the metadata.
          It can be in addition to the ust_baddr events suggeted by
          Paul.</font></b><b>
      </b><b><br>
      </b>
      <b><br>
      </b><b><font size="2" face="sans-serif">Amit</font></b><b>
      </b><b><br>
      </b>
      <b><br>
      </b><b><font size="2" color="#000080" face="sans-serif">Amit
          Margalit</font></b><b>
      </b><b><br>
      </b><b><font size="2" color="#808000" face="sans-serif">IBM XIV </font></b><b><font
          size="2" face="sans-serif">-
          <i>Storage Reinvented</i></font></b><b>
      </b><b><br>
      </b><b><font size="2" face="sans-serif">XIV-NAS Development Team</font></b><b>
      </b><b><br>
      </b><b><font size="2" face="sans-serif">Tel. 03</font></b><b><font
          size="2" face="Arial">-689-7774</font></b><b>
      </b><b><br>
      </b><b><font size="2" face="Arial">Fax. 03-689-7230</font></b><b>
      </b><b><br>
      </b>
      <b><br>
      </b>
      <b><br>
      </b>
      <b><br>
      </b><b><font size="1" color="#5f5f5f" face="sans-serif">From: &nbsp; &nbsp;
          &nbsp;
          &nbsp;</font></b><b><font size="1" face="sans-serif">"Woegerer,
          Paul"
          <a class="moz-txt-link-rfc2396E" href="mailto:Paul_Woegerer@mentor.com">&lt;Paul_Woegerer@mentor.com&gt;</a></font></b><b>
      </b><b><br>
      </b><b><font size="1" color="#5f5f5f" face="sans-serif">To: &nbsp; &nbsp; &nbsp;
          &nbsp;</font></b><b><font size="1" face="sans-serif">Matthew
          Khouzam <a class="moz-txt-link-rfc2396E" href="mailto:matthew.khouzam@ericsson.com">&lt;matthew.khouzam@ericsson.com&gt;</a></font></b><b>
      </b><b><br>
      </b><b><font size="1" color="#5f5f5f" face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
          &nbsp;</font></b><b><font size="1" face="sans-serif">lttng-dev
          <a class="moz-txt-link-rfc2396E" href="mailto:lttng-dev@lists.lttng.org">&lt;lttng-dev@lists.lttng.org&gt;</a>,
          Mathieu Desnoyers <a class="moz-txt-link-rfc2396E" href="mailto:mathieu.desnoyers@efficios.com">&lt;mathieu.desnoyers@efficios.com&gt;</a></font></b><b>
      </b><b><br>
      </b><b><font size="1" color="#5f5f5f" face="sans-serif">Date: &nbsp; &nbsp;
          &nbsp;
          &nbsp;</font></b><b><font size="1" face="sans-serif">09/10/2013
          06:47 PM</font></b><b>
      </b><b><br>
      </b><b><font size="1" color="#5f5f5f" face="sans-serif">Subject: &nbsp;
          &nbsp;
          &nbsp; &nbsp;</font></b><b><font size="1" face="sans-serif">Re:
          [lttng-dev]
          Getting function names with &nbsp; &nbsp; &nbsp; &nbsp;lttng-ust-cyg-profile.so</font></b><b>
      </b><b><br>
      </b>
      <hr noshade="noshade">
      <b><br>
      </b>
      <b><br>
      </b>
      <b><br>
      </b><b><tt><font size="2">On 09/10/2013 05:37 PM, Matthew Khouzam
            wrote:<br>
            &gt; On 13-09-10 03:00 AM, Woegerer, Paul wrote:<br>
            &gt;&gt; Hi Alexandre,<br>
            &gt;&gt;<br>
            &gt;&gt; For trivial examples you can go with 'nm -CS' (or
            the like), but
            when<br>
            &gt;&gt; you start to use liblttng-ust-cyg-profile.so in
            combination with
            shared<br>
            &gt;&gt; objects you will need to record base address
            information as well
            (to<br>
            &gt;&gt; allow you map a virtual memory address at a given
            point in time
            to<br>
            &gt;&gt; offset and path of a shared object (or
            executable)).<br>
            &gt;&gt;<br>
            &gt;&gt; That is one of the reasons why I have submitted:<br>
            &gt;&gt; </font></tt></b><b><a moz-do-not-send="true"
href="http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html"><tt><font
              size="2">http://lists.lttng.org/pipermail/lttng-dev/2013-August/021264.html</font></tt></a></b><b><tt><font
            size="2"><br>
            &gt; This is a very interesting approach, +1 from me on
            that.<br>
            <br>
            Thanks.<br>
            <br>
            With that approach no redundant data (that is already
            available as<br>
            debuginfo) gets replicated in the actual trace data.<br>
            Only the bare minimum of information gets traced to allow
            you at any<br>
            time to map a VM address to a debuginfo address + debuginfo
            location.<br>
            <br>
            -- <br>
            Paul Woegerer, SW Development Engineer<br>
            Sourcery Analyzer &lt;</font></tt></b><b><a
          moz-do-not-send="true"
          href="http://go.mentor.com/sourceryanalyzer"><tt><font
              size="2">http://go.mentor.com/sourceryanalyzer</font></tt></a></b><b><tt><font
            size="2">&gt;<br>
            Mentor Graphics, Embedded Software Division<br>
            <br>
            <br>
            _______________________________________________<br>
            lttng-dev mailing list<br>
            <a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>
          </font></tt></b><b><a moz-do-not-send="true"
          href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font
              size="2">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a></b><b><tt><font
            size="2"><br>
            <br>
          </font></tt></b>
      <b><br>
      </b>
    </blockquote>
    <b><br>
    </b><b><br>
    </b>
    <pre class="moz-signature" cols="72">-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <a class="moz-txt-link-rfc2396E" href="http://go.mentor.com/sourceryanalyzer">&lt;http://go.mentor.com/sourceryanalyzer&gt;</a>
Mentor Graphics, Embedded Software Division</pre>
  </body>
</html>

--------------030500020709040500010606--


--===============1960706881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1960706881==--
