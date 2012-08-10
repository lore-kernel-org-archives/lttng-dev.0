From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: qemuarm: Session dameon died (exit status 0)
Date: Fri, 10 Aug 2012 10:31:20 -0400
Message-ID: <50251B38.8040205__27185.7614316561$1344609113$gmane$org@gmail.com>
References: <CAKe51+3mCaia8a--vH8KVbtA+kkzGsKx2=C0-K1qEvNY42wRkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1956354245=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gh0-f176.google.com ([209.85.160.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SzqFM-0005Nb-BB
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 10:31:28 -0400
Received: by ghbz10 with SMTP id z10so1884331ghb.35
	for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2012 07:31:22 -0700 (PDT)
In-Reply-To: <CAKe51+3mCaia8a--vH8KVbtA+kkzGsKx2=C0-K1qEvNY42wRkQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Barrette <paulbarrette@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1956354245==
Content-Type: multipart/alternative;
 boundary="------------080508090508020906090009"

This is a multi-part message in MIME format.
--------------080508090508020906090009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Can you try to start the lttng-sessiond manually and see if there is
error message (with full logging enabled: lttng-sessiond -vvv)

Yannick

On 2012-08-10 10:02, Paul Barrette wrote:
> Hi all,
> lttng-modules 2.0.4
> lttng-tools 2.0.4
> linux kernel 3.4.x
>
> I am running  qemuarm and seeing the following issue when running
> "lttng create":
> Error: Session daemon died (exit status 0)
>
> Is there a patch I am missing for arm?
>
> Thanks
> Pb
>
> -- 
> --
> Paul Barrette
> Linked In Profile <http://ca.linkedin.com/pub/paul-barrette/11/b42/a96>
> http://sitarplayer.net
> O"
>  \\=^%
>  (*)---(*)
> ^^~~^~~~^^^~~^
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------080508090508020906090009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi,<br>
    <br>
    Can you try to start the lttng-sessiond manually and see if there is
    error message (with full logging enabled: lttng-sessiond -vvv)<br>
    <br>
    Yannick<br>
    <br>
    On 2012-08-10 10:02, Paul Barrette wrote:
    <blockquote
cite="mid:CAKe51+3mCaia8a--vH8KVbtA+kkzGsKx2=C0-K1qEvNY42wRkQ@mail.gmail.com"
      type="cite">Hi all,
      <div>lttng-modules 2.0.4</div>
      <div>lttng-tools 2.0.4</div>
      <div>linux kernel 3.4.x</div>
      <div><br>
      </div>
      <div>I am running &nbsp;qemuarm and seeing the following issue when
        running "lttng create":</div>
      <div>Error: Session daemon died (exit status 0)</div>
      <div><br>
      </div>
      <div>Is there a patch I am missing for arm?</div>
      <div><br>
      </div>
      <div>Thanks</div>
      <div>Pb<br clear="all">
        <div><br>
        </div>
        -- <br>
        --<br>
        Paul Barrette<br>
        <a moz-do-not-send="true"
          href="http://ca.linkedin.com/pub/paul-barrette/11/b42/a96"
          target="_blank">Linked In Profile</a><br>
        <a moz-do-not-send="true" href="http://sitarplayer.net"
          target="_blank">http://sitarplayer.net</a><br>
        <font face="verdana"><font color="black"><font>&#336;</font></font></font>
        <br>
        <font face="verdana"><font color="black"><font>&nbsp;\\=^% <br>
              &nbsp;(*)---(*)</font></font></font> <br>
        <font face="courier new">^^~~^~~~^^^~~^</font>
        <div style="text-align:left"><br>
        </div>
        <br>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------080508090508020906090009--


--===============1956354245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1956354245==--
