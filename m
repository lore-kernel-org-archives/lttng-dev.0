From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: relaunch sessiond if relayd gets killed.
Date: Tue, 21 Oct 2014 00:10:56 +0530
Message-ID: <CAM5kDqyUozsxPaS55qrf2nNx7c8p7vn77g7q3nvQei6se6ak0A__44118.130071047$1413830522$gmane$org@mail.gmail.com>
References: <CAM5kDqwpEdCFgF07O5b3qZZvxqY=KvyFOnkr+WWsda2jOdXYTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0782880929=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XgHt8-0005g3-6h
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 14:41:07 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi2so7176250wib.2
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 11:40:56 -0700 (PDT)
In-Reply-To: <CAM5kDqwpEdCFgF07O5b3qZZvxqY=KvyFOnkr+WWsda2jOdXYTg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0782880929==
Content-Type: multipart/alternative; boundary=001a11c3498c1e29510505df0e45

--001a11c3498c1e29510505df0e45
Content-Type: text/plain; charset=UTF-8

one more point:
if there is a way to kill/exit sessiond on a connection reset then will be
easier to re-launch it again

wondering if anything of that sort can be done

Thanks,
Anand Neeli

On Tue, Oct 21, 2014 at 12:02 AM, Anand Neeli <anand.neeli@gmail.com> wrote:

> Hi All,
> if relayd gets killed i see there is connection reset which happens at
> client.
> Is there a way to relaunch the sessiond/consumerd on a connection reset?
>
> can some hooks be added or helper application be written to relaunch
> sessiond in case exit of relayd or any other connection reset?
>
> Thanks,
> Anand Neeli
>

--001a11c3498c1e29510505df0e45
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">one more point:<div>if there is a way to kill/exit session=
d on a connection reset then will be easier to re-launch it again</div><div=
><br></div><div>wondering if anything of that sort can be done</div><div><b=
r></div><div>Thanks,</div><div>Anand Neeli</div></div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Tue, Oct 21, 2014 at 12:02 AM, Anan=
d Neeli <span dir=3D"ltr">&lt;<a href=3D"mailto:anand.neeli@gmail.com" targ=
et=3D"_blank">anand.neeli@gmail.com</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div dir=3D"ltr">Hi All,<div>if relayd gets killed i see t=
here is connection reset which happens at client.</div><div>Is there a way =
to relaunch the sessiond/consumerd on a connection reset?</div><div><br></d=
iv><div>can some hooks be added or helper application be written to relaunc=
h sessiond in case exit of relayd or any other connection reset?</div><div>=
<br></div><div>Thanks,</div><div>Anand Neeli</div></div>
</blockquote></div><br></div>

--001a11c3498c1e29510505df0e45--


--===============0782880929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0782880929==--
