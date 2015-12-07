From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Relayd trace drops
Date: Mon, 7 Dec 2015 23:37:24 +0530
Message-ID: <CACd+_b7ScRDo9uL+neOnA2pqVVwexsPsbBd2mBS--yy7Amxbmg__49965.5875181363$1449511710$gmane$org@mail.gmail.com>
References: <CACd+_b7qEeW1XD1H_0MT4dDqwLv68rfOURfNDRh6SO=xS4k-Og@mail.gmail.com>
 <CA+jJMxsuF+Ywvvhe3L4OqBHTsohyFffPoF4mZWFDqPvBC-P80w@mail.gmail.com>
 <CACd+_b5AGJKWH58Kq3QP8qW8R7Q9JH3fqbEwU=z8pyg5-DL=KQ@mail.gmail.com>
 <CA+jJMxsJReP4ZO2bSJP-rJe+UoJzT09Pix1LhEypbsww_nwrsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c3787ab26586052652ba82
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1a60CA-0007Qe-V2
 for lttng-dev@lists.lttng.org; Mon, 07 Dec 2015 13:07:35 -0500
Received: by lbblt2 with SMTP id lt2so71565981lbb.3
 for <lttng-dev@lists.lttng.org>; Mon, 07 Dec 2015 10:07:25 -0800 (PST)
In-Reply-To: <CA+jJMxsJReP4ZO2bSJP-rJe+UoJzT09Pix1LhEypbsww_nwrsA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--001a11c3787ab26586052652ba82
Content-Type: multipart/alternative; boundary=001a11c3787ab26581052652ba80

--001a11c3787ab26581052652ba80
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have attached the complete profiling scripts here, its a bit shabby, im
new to python.

There is a README which has the details on how to execute it.
Im using a Yocto 1.6 on x86_64 platforms on both the nodes.


Running this script when there are other sessions running seems to
reproduce this problem easily.
Please try it and let me know if you have any issues reproducing the
problem.

Regards,
Aravind.

On Sat, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT <aravind.ht@gmail.com> wrote:
> > I am using 2.6.0 .I will try to share the code that I'm using here in
> some
> > time. If there are any specific fixes that are relevant to this issue,
> see
> > if you can provide a link to them. I would ideally like to try them out
> > before trying a full upgrade to the latest versions.
>
> Hi,
>
> Can you provide more information on the system? Which distribution,
> architecture, kernel version?
>
> The verbose sessiond logs might help pinpoint any unexpected behaviour
> here (are all applications registering as expected?).
>
> J=C3=A9r=C3=A9mie
>
> >
> > On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=A9mie Galarneau
> > <jeremie.galarneau@efficios.com> wrote:
> >>
> >> Hi Aravind,
> >>
> >> Can't say I have looked at everything you sent yet, but as a
> >> preemptive question, which version are we talking about here? 2.6.0 or
> >> 2.6.1? 2.6.1 contains a lot of relay daemon fixes.
> >>
> >> Thanks,
> >> J=C3=A9r=C3=A9mie
> >>
> >> On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT <aravind.ht@gmail.com>
> wrote:
> >> > Hi,
> >> >
> >> > I am trying to obtain the performance characteristics of lttng with
> the
> >> > use
> >> > of test applications. Traces are being produced on a local node and
> >> > delivered to relayd that is running on a separate node for storage.
> >> >
> >> > An lttng session with the test applications producing an initial bit
> >> > rate of
> >> > 10 kb/s is started and run for about 30 seconds. The starting
> sub-buffer
> >> > size is kept at 128 kb and sub-buf count at 4. The session is then
> >> > stopped
> >> > and destroyed and traces are analyzed to see if there are any drops.
> >> > This is
> >> > being done in a loop with every subsequent session having an increme=
nt
> >> > of 2
> >> > kb/s as long as there are no drops. If there are drops, I increase t=
he
> >> > buffer size by a factor of x2 without incrementing the bit rate.
> >> >
> >> > I see trace drops happening consistently with test apps producing
> traces
> >> > at
> >> > less than 40 kb/s, it doesnt seem to help even if I started with 1mb
> x 4
> >> > sub-buffers.
> >> >
> >> > Analysis :
> >> >
> >> > I have attached the lttng_relayd , lttng_consumerd_64 logs and the
> >> > entire
> >> > trace directory, hope you will be able to view it.
> >> > I have modified lttng_relayd code to dump the traces being captured =
in
> >> > the
> >> > lttng_relayd logs along with debug info.
> >> >
> >> > Each test app is producing logs in the form of  :
> >> > "TraceApp PID - 31940 THID - 31970 @threadRate - 1032 b/s appRate -
> 2079
> >> > b/s
> >> > threadTraceNum - 9 appTraceNum - 18  sleepTime - 192120"
> >> >
> >> > The test application PID, test application thread id, thread bit rat=
e,
> >> > test
> >> > app bit rate, thread trace number and application trace number s are
> >> > part of
> >> > the trace. So in the above trace, the thread is producing at 1 kb/s
> and
> >> > the
> >> > whole test app is producing at 2 kb/s.
> >> >
> >> > If we look at the babeltrace out put, we see that the Trace with
> >> > TraceApp
> >> > PID - 31940 appTraceNum 2 is missing , with 1, 3, 4, 5 and so on bei=
ng
> >> > successfully captured.
> >> > I looked at the lttng_relayd logs and found that trace of "appTraceN=
um
> >> > 2" is
> >> > not delivered/generated by the consumerd to the relayd in sequence
> with
> >> > other traces. To rule out that this is not a test application proble=
m,
> >> > you
> >> > can look at line ltttng_relayd log : 12778 and see traces from
> >> > appTraceNum -
> >> > 1 to appTraceNum - 18 including the appTraceNum 2 are "re-delivered"
> by
> >> > the
> >> > consumerd to the relayd.
> >> > Essentially, I see appTraceNum 1 through appTraceNum 18 being
> delivered
> >> > twice, once individually where appTraceNum 2 is missing and once as =
a
> >> > group
> >> > at line 12778 where its present.
> >> >
> >> >
> >> > Request help with
> >> > 1. why traces are delivered twice, is it by design or a genuine
> problem
> >> > ?
> >> > 2. how to avoid traces being dropped even though buffers are
> >> > sufficiently
> >> > large enough ?
> >> >
> >> >
> >> > Regards,
> >> > Aravind.
> >> >
> >> > _______________________________________________
> >> > lttng-dev mailing list
> >> > lttng-dev@lists.lttng.org
> >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >> >
> >>
> >>
> >>
> >> --
> >> J=C3=A9r=C3=A9mie Galarneau
> >> EfficiOS Inc.
> >> http://www.efficios.com
> >
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c3787ab26581052652ba80
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have attached the complete profil=
ing scripts here, its a bit shabby, im new to python.</div><div><br></div><=
div>There is a README which has the details on how to execute it.=C2=A0</di=
v><div>Im using a Yocto 1.6 on x86_64 platforms on both the nodes.=C2=A0</d=
iv><div><br></div><div><br></div><div>Running this script when there are ot=
her sessions running seems to reproduce this problem easily.</div><div>Plea=
se try it and let me know if you have any issues reproducing the problem.<b=
r></div><div><br></div><div>Regards,</div><div>Aravind.</div></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Dec 5, 2015 at 5:=
23 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:=
jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficio=
s.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT &lt;<a href=3D"mailto:ara=
vind.ht@gmail.com">aravind.ht@gmail.com</a>&gt; wrote:<br>
&gt; I am using 2.6.0 .I will try to share the code that I&#39;m using here=
 in some<br>
&gt; time. If there are any specific fixes that are relevant to this issue,=
 see<br>
&gt; if you can provide a link to them. I would ideally like to try them ou=
t<br>
&gt; before trying a full upgrade to the latest versions.<br>
<br>
</span>Hi,<br>
<br>
Can you provide more information on the system? Which distribution,<br>
architecture, kernel version?<br>
<br>
The verbose sessiond logs might help pinpoint any unexpected behaviour<br>
here (are all applications registering as expected?).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
J=C3=A9r=C3=A9mie<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=A9mie Galarneau<br>
&gt; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galarnea=
u@efficios.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Aravind,<br>
&gt;&gt;<br>
&gt;&gt; Can&#39;t say I have looked at everything you sent yet, but as a<b=
r>
&gt;&gt; preemptive question, which version are we talking about here? 2.6.=
0 or<br>
&gt;&gt; 2.6.1? 2.6.1 contains a lot of relay daemon fixes.<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; J=C3=A9r=C3=A9mie<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT &lt;<a href=3D"mailto:a=
ravind.ht@gmail.com">aravind.ht@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am trying to obtain the performance characteristics of lttn=
g with the<br>
&gt;&gt; &gt; use<br>
&gt;&gt; &gt; of test applications. Traces are being produced on a local no=
de and<br>
&gt;&gt; &gt; delivered to relayd that is running on a separate node for st=
orage.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; An lttng session with the test applications producing an init=
ial bit<br>
&gt;&gt; &gt; rate of<br>
&gt;&gt; &gt; 10 kb/s is started and run for about 30 seconds. The starting=
 sub-buffer<br>
&gt;&gt; &gt; size is kept at 128 kb and sub-buf count at 4. The session is=
 then<br>
&gt;&gt; &gt; stopped<br>
&gt;&gt; &gt; and destroyed and traces are analyzed to see if there are any=
 drops.<br>
&gt;&gt; &gt; This is<br>
&gt;&gt; &gt; being done in a loop with every subsequent session having an =
increment<br>
&gt;&gt; &gt; of 2<br>
&gt;&gt; &gt; kb/s as long as there are no drops. If there are drops, I inc=
rease the<br>
&gt;&gt; &gt; buffer size by a factor of x2 without incrementing the bit ra=
te.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I see trace drops happening consistently with test apps produ=
cing traces<br>
&gt;&gt; &gt; at<br>
&gt;&gt; &gt; less than 40 kb/s, it doesnt seem to help even if I started w=
ith 1mb x 4<br>
&gt;&gt; &gt; sub-buffers.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Analysis :<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I have attached the lttng_relayd , lttng_consumerd_64 logs an=
d the<br>
&gt;&gt; &gt; entire<br>
&gt;&gt; &gt; trace directory, hope you will be able to view it.<br>
&gt;&gt; &gt; I have modified lttng_relayd code to dump the traces being ca=
ptured in<br>
&gt;&gt; &gt; the<br>
&gt;&gt; &gt; lttng_relayd logs along with debug info.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Each test app is producing logs in the form of=C2=A0 :<br>
&gt;&gt; &gt; &quot;TraceApp PID - 31940 THID - 31970 @threadRate - 1032 b/=
s appRate - 2079<br>
&gt;&gt; &gt; b/s<br>
&gt;&gt; &gt; threadTraceNum - 9 appTraceNum - 18=C2=A0 sleepTime - 192120&=
quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The test application PID, test application thread id, thread =
bit rate,<br>
&gt;&gt; &gt; test<br>
&gt;&gt; &gt; app bit rate, thread trace number and application trace numbe=
r s are<br>
&gt;&gt; &gt; part of<br>
&gt;&gt; &gt; the trace. So in the above trace, the thread is producing at =
1 kb/s and<br>
&gt;&gt; &gt; the<br>
&gt;&gt; &gt; whole test app is producing at 2 kb/s.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If we look at the babeltrace out put, we see that the Trace w=
ith<br>
&gt;&gt; &gt; TraceApp<br>
&gt;&gt; &gt; PID - 31940 appTraceNum 2 is missing , with 1, 3, 4, 5 and so=
 on being<br>
&gt;&gt; &gt; successfully captured.<br>
&gt;&gt; &gt; I looked at the lttng_relayd logs and found that trace of &qu=
ot;appTraceNum<br>
&gt;&gt; &gt; 2&quot; is<br>
&gt;&gt; &gt; not delivered/generated by the consumerd to the relayd in seq=
uence with<br>
&gt;&gt; &gt; other traces. To rule out that this is not a test application=
 problem,<br>
&gt;&gt; &gt; you<br>
&gt;&gt; &gt; can look at line ltttng_relayd log : 12778 and see traces fro=
m<br>
&gt;&gt; &gt; appTraceNum -<br>
&gt;&gt; &gt; 1 to appTraceNum - 18 including the appTraceNum 2 are &quot;r=
e-delivered&quot; by<br>
&gt;&gt; &gt; the<br>
&gt;&gt; &gt; consumerd to the relayd.<br>
&gt;&gt; &gt; Essentially, I see appTraceNum 1 through appTraceNum 18 being=
 delivered<br>
&gt;&gt; &gt; twice, once individually where appTraceNum 2 is missing and o=
nce as a<br>
&gt;&gt; &gt; group<br>
&gt;&gt; &gt; at line 12778 where its present.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Request help with<br>
&gt;&gt; &gt; 1. why traces are delivered twice, is it by design or a genui=
ne problem<br>
&gt;&gt; &gt; ?<br>
&gt;&gt; &gt; 2. how to avoid traces being dropped even though buffers are<=
br>
&gt;&gt; &gt; sufficiently<br>
&gt;&gt; &gt; large enough ?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt; Aravind.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; _______________________________________________<br>
&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.=
lttng.org</a><br>
&gt;&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev" rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev</a><br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; J=C3=A9r=C3=A9mie Galarneau<br>
&gt;&gt; EfficiOS Inc.<br>
&gt;&gt; <a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_=
blank">http://www.efficios.com</a><br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</div></div></blockquote></div><br></div>

--001a11c3787ab26581052652ba80--

--001a11c3787ab26586052652ba82
Content-Type: application/rar; name="Lttng_dev_mailing_scripts.rar"
Content-Disposition: attachment; filename="Lttng_dev_mailing_scripts.rar"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ihw9sy6j0

UmFyIRoHAM+QcwAADQAAAAAAAACKVHQgkFAA4gAAALIBAAACmW7kSoG6h0cdMysAIAAAAEx0dG5n
X2Rldl9tYWlsaW5nX3NjcmlwdHNcYW5hbHl6ZV9zY3JpcHQuc2gAsMMGZggVUQy9kBE3zhX21BUR
IRXWjqV2o6XUiJbkEmAmBdEZ3dEkUZcGrmHQqDwG9FWVR+v4K5BQV+sn6o9q8HtPuBVaiurix5zu
cFNZ3RWWHUH6chXfDTcclhuGBq11NL3dZAYK5AOMtu0jGt6+lg6+3PH2jAg98a2ntJ2203i1gIgI
zj5eG3SDsvSRT4FoBjyYn90i4sHEnVBLZFDLpRjofEZeOwWy/QsqF4/PeMOXN6EjRqNxIpWdGl0C
JJmyiaGiEVpDwe4FKv/4H8cIHzNfHzR2Y5MUClsJh5pW19P5HiVFOyAbB3QgkFAAZAAAAGwAAAAC
DPBAiIe6h0cdMysAIAAAAEx0dG5nX2Rldl9tYWlsaW5nX3NjcmlwdHNcYW5hbHl6ZV90cmFjZXMu
c2gAsIbFGA1RUMvdAM5yivnCUWoKWKBbGxgkcGtbQnAXwRs4QAJFI5izKm9QHqVnlJOGZOvku4lA
tUGWOjI735speaLVuIU5IgpbX3isDYMPliirwYduY7okoSvH7/1ms9Uwo9GtWqYSRd16HHQgkEkA
lAAAAKcAAAACUIp04ZC6h0cdMyQAIAAAAEx0dG5nX2Rldl9tYWlsaW5nX3NjcmlwdHNcY2xlYW51
cC5zaACwKFQPCVGUzL2YFT3uiojQoIV6N83RKI6BhGMY0slkOzotBXe6FQiMoRUHSH34wM1Nnhnn
wMw5o3PmDfbfHRDlQ+Bq1cTdjLFTzY7hKdUdLjVdXjI3mps71TywQK5MutYyUddAt9IyuHP2oMcu
ORXrrIUJVAKdUazR8ICa8Nym7HcFHxbRck8E5MvI/5P5/fzzjpLDLajwgHKNdCCQVABNAAAAWwAA
AALUO4yGirqHRx0zLwAgAAAATHR0bmdfZGV2X21haWxpbmdfc2NyaXB0c1xjbGVhbl9SZW1Ob2Rl
X2FwcHMuc2gAsKbMIQ0VUQvkjeUVpBAog4YUkTiHTTobONm79AgvgWSCeaTqG8nyMqnF5S91uOsp
+8H3sU2ipYbFfSp3LAuy6gxuXEkT6sv4gEz0EXGarU+IvEt0IJBNAJwAAAC1AAAAAl4PMQuTuodH
HTMoACAAAABMdHRuZ19kZXZfbWFpbGluZ19zY3JpcHRzXGNvbmZpZ0ZpbGUudHh0ALAy1yIJlRjM
vhE3zhV4DW2gjrdCoutUGXWiJJLIsG2SEn8Cr3p0UaUIFkHiWZnszOTe2e0/B8fcN6jOYErVV2Fz
eDMbgm082uagLmUZNRLe7TsW0NAXgLkuyJEMNSIby7XoGn5GGrV6/wblvUGDSLNiDtGbye6Np5y/
rp3psFvgyWFFbSGhH4zL7O4VeOGxjHR5TJtaZbwcSX9IMSXlPqCasXQgkFIAIAkAAFkiAAACwd7b
1pa6h0cdMy0AIAAAAEx0dG5nX2Rldl9tYWlsaW5nX3NjcmlwdHNcbGF1bmNoX3NjcmlwdF9STi5w
eQCwKr4XDBmQzM0RPJWZf9H0UccEDby23I3ubwBgQDZJszMg29uQSPP1l4GHEk5ELTSWLgu7eDe+
NGucLaSdVRJSK4G47uQYMwB2BdpE1XpqqNcJKvpavgg89rwUCCao9B7v2b8L72/1st77uaDtcbrM
5XXHoDY3ux3x32E+7+Z+Xygeid2J9XJcfqzvNzp9+xpzrlM4et15xZh+YF7WmPmn0g8uXSeSQTIz
2dA649WyRUyzsEydMx5GFceYWhjMaT6vRq+JBHrBxOuxH1Pm4TVyXB8VxaggkvxIzq9aJgmfUtqF
dg79D5uJ8s67HNPL+fo++PViU1gj+QOguskbQMXxHLrsHzgSde0SHoBi3mamcJpazQPtigS07Xcb
eNrN+zGt1VGcrqCMLC9jW842gEkf7laQ/SsLutMUZxFT4ONMuN+7HlYEklZsAJ2942w0rk8h8LTc
Dqcb28/4YsPL1YcXF0dGLo6ef7+b283u/DB9sQ6y7GQxw+RzpYy+5zSFnnhi14wswtm8K8nlk+6x
9cIOHYQeOti9nxw5Opn9pfPkchbgt9egZGHtSnbGWGSgRwndFftYK25Hlum9uOJUQTeBI7Rc5NgM
s41HWtAaMDLvrSEGyRAMW1kZ5M+NqfX0EBLQAE40eTKvF+DGAKh61G54ry+Ajc/XxnDe+uMQUa34
uRD/2xm5I+1vgDQjNuaZkFccg/zvPxEsE41SRQMqdAfEevvWSY1Vvz2pFToigJ7V2gQ2aOe70OOs
N2SjmjfdaZgs61RbQBaqxnQdAuhr/plpoQiGIgnrFroUPRLXUqaC465cHvBBHvG7prpFP7umbxJd
PfTIgMiLQ3jNZjM5EQhk+EOxrL/gNrsrSGsLxeOZGuXG3LiDhc0mjAZpsuZ/+4ZMgnx0O/wD+0X8
jNsQYN/fvX/8XeAP59yQJgtFuIkLgdrZ6hCgJqGGDvQzxQv3HWY4Y6yHaB4xHQ3ABTsAQoiHXGQJ
9XPNxlJgwD/f+uXj/LOdWHi6cJqI8TPj4NbcmYjwhujm1Z1wkOFvsddsSZSqGHfVvxprfnQCqa8B
RsWuA1uaApScRaQlp2Z4u+/UUlobhEj8ze94fZuHLqHh6w3KP7n8/KCccWAMD8yaqUJJ859WdwpP
Q16yncZ9XWOi7SKd612fZquenZUp0d3X1BMzhCqATtNDTnQt44Da98MCJSTGtjaapSYqs474qOz3
c9oFZ5hVhpbF7eFkXUAkmQ7QBETlPmGu2inf0jEZGTRsM0G1i3YtYFd0SqTYgsAfqt2t6e6SpeC2
1EOmV0KOXvb8inrorbOwPo6JaTUWGUKIo3+wMc1JfLHFIxMoHFAwMvC9I6Di12P0SWNWNph2yCT2
U20Ah9RazptWwDD17IiXroPsSQ96l6bdv6U+DMSadtCe17Sg5Wv+7/S6rpE15BAI/sZ9Bav6lEwA
Prol9peOcLYA6Kxf8CJub1FGEhXoEbQBKWibjuKfskN/uW1p8avW84UpghO/loBcHdNsULzT/19y
7TCwuXBYUPv56TUz6Vgy2oDMm8o6VL4IkrWdShGAo59nfV7C/C81H9Ygk9JWp90JUJCTK0rNKXI2
ZRtP9BfGbSmtBFD7/aYEGBIClYK8gWxjsWjqlP5f6L4wFA2lQKXNa2hLZ+n2g5NkC7ki3CdKy9mH
ns9gHnnXUzlKu3cjUMcdm1L7rNOPsZ5W3PQMAJ2Okr1s31zrX0a7bnoV37sK9I6HiXSKgwD5Z8Fb
NVC/0OkHtmny8aaUEEbexIi7zWI7RvcUBYyvcQG4qOHGKNTXs3/TdgbjBL3JWIkrsv//ejsX0iE2
oDv8drr4S6XatoTpUy5ujllUOhjgngdPYLaj6ZdOfXQuKVxyBV0KshEf2REsWBqv+a+Ulh/yeke7
ivyxsuPPhSw0RYOUgbrzG48fWw0TbAs+VDGVqNFqSbSsUID0keGB25eDy3Q7SC6x8wYRwATRqxOw
US36RL/c4b1NMjpLwbk6n9C7K+ud9ql11aesYnvt7VTQhPY1hrELzYSIQtIz9cMy2tiPxyLPVNxj
Bxhu+R47fJCT1I29EV414zHltSz1j3r+yxEeYztXex5yObU+CJbspv7BOFlAj7dIX5UH1SL/AFxT
lzIiNXaym+MlQ3C5BqgK+xQKjdPsh5G1l9uKbn7xu7FVxmyyLfJgUEceBigctf+vBwPHF7Mudvhi
WldU3tOhhEX3s+17Pp3Tub9QXX6RbfSOVI3TGjjNQMUhcFkK1QrnZkBsLNIst9jFngtzL/3r/s4a
4e9uvW1pbez9A0WveIu0TXGN+gYX9mPUR3YFl+gMEVF5DCHKwaZ/t87sr7DWRPLwsh8Voe4mMj8s
XwxUSGhy7q2fjpfDbDHo/DuCNhBEgjKZVZmCwh/SQCpUQQ4VenMTY95cCpoNEYz9lRD0/jyu7HUc
iwBD8qCUi6aWeCXIHuxiCyqaRhV5iavapAYycNkeiQVBufi+YUdjtsQCcU1ATNJh2QNMTa4DLqct
oBCJ6gF41OrF2QMqUVAOnmXbIDSSaw/4j8SLu/V0kZUkP+Y/m9qSnFzLdExOSVxoSzTVzw0XrZ8w
YZqKGebVCqy9NVE1z+Afj1ttmlH5oh03l/0FooMx0qFgPgPBBcGtnM8Cr7k6YfATsmHr+ejfpPdP
EhBCN6yzbPXkVrGqBVuUGtzgC1/KG1oR7c3O72W0x1ikKcD1OSi1K236JiJMyv0U9a2dVrkzdCge
G74LVwtwxo8+ApElTsvvuGIMLoCY1uXjm06W3V2xN7+yD09194gUUAi9hYRbf5ceiDQr3N1PwWi6
yhx25qt+LDSI8q25LS3R/wRrvFoEOpqMyWl8VySXopJaxrr4pscW+T9JPkS9hTXVqr1wqk5ZIG10
69iHNRmDbNSi5aMfzs2FQKxaqTsi7GhP4oXFgt8LlyarVo0GZ1jhC36th9dCDH8Yl8NjSkj7TvDX
OTGEnHs6A7/gOTSPV4xCAH1M/rCz5C4I9hehYq9e0OAOsjyY4WoH7OQOyF4VUzOyMjYmJjYgl2YQ
3zxvl2gzr4izIDcZKQdrVp4D8uChFki2Vvxf4K1C3osu6JueyxjnB1LEU7/yS7OjyhcP8CvNYeHc
gBy3/yDa23QgkE4A8gUAANESAAACIG3pb6O6h0cdMykAIAAAAEx0dG5nX2Rldl9tYWlsaW5nX3Nj
cmlwdHNcbHR0bmdfdGVzdEFwcC5jALA/q2sMAY0MzM/NgZvu/xXCQVhNpSNujXAauOXPSvSsVyVh
x3C7TQIKJJuLZNJ5eiWPUT/vgG5rW00z3oSXckpdtaN80BG3x7wnj7OU/Md4SePuBPhJA8JHhJ/A
77Ti7cLDIuJ+Bhp3h7OOoeSe1vLPJsNtdenGZaDsnD+h+xBozsv0hZrMzRKh/LrNto7ELjQcaiTz
7anmViFDirjO1YP6x8hAZvQRgwXc+dXcQsuznd2PBs/Xt4DnZuQDAua77lebo5VcF7nEl9ln7vtr
S7XRsO9hVx3+a8rf57+MWz/LZH5EGoDl4V4BDYntj1EttS6IFnoMYa7dJuckLz0m2tsdcQKNqHPD
mxkYwVwVmXc3avtZdv7BB/KqAYAjsOXswwwDDwt/NEjaf8nW/DZt1zLMM6Gf4BQ5woz4K5ttzPcr
ABkv+4AsOP1Yr130q83tx3vcRyL93Bf/S9iiweysOdjW2brjHKyN/Ey8pD3YDK7dYYjMrauZyFKs
6Xa60cfxhjPvqvw9Y01sBKc/2v3KCnktGlG7HaC3BMmh8RXEZxGSN+JbUbROe8GKVuvZQG/TN0L4
VBB4PY2mkitbIQnKuH3ebWzvxRLvIwbHBlKqP5rf3KMgadxHlDA9tw047kjs0RcOmdUFz+3BgMiJ
715wiqfPmpVmWUx7Rm2mBcMHbtWZXF6EVtsUAPOZyZXXpUkVJUrjoXKDkAdR6OD+tf76n0Uv40Ka
JmhDf/CDBRSaZ1O31TA/8J+90wcdYriwsvZHXswT+MiXWee0CDUTS2DotZk40KEC69BXcBgmFo4d
pVgEE1kjI7uDjCIcI4y8WyJdB8+rg9y5ErRpLgF3aTsCtWSeCT1krijxVyXerkRR4Ax4J/JC3fRV
/wHorjkRNKr3iGmo6CtJ6fuDTYr//I7mzhIFqgcGAj+zLRjjevA6L361BwkQgpOEafEuy9AANvQL
O6/EBrtZNAIsUS8bcM9Y9gzc6cIhPE0GutmWbEWY20N74p2NSHGcqyHPECFRJ8ghEODZanvLL9hr
sBoDDJqXQazO86xDucFa9f4WOgDwEn/yvLVJ1WCUVoZRLdEeo5Z6QI+2yzEYcHbk/oXrZHO2rIsz
Tbe5CPaNhh8rjfiDOlwuecz+XAy5SKCWyo+hmTpwctkL54WS/2ePr9iz0cMYvSd0+OqIHws9/i4f
iX5fF3B4Ef68W7TCsA/mPhvICvq6RSNetLDWcHL1GTDTdh5JVXnxKkxgHhopMZ0i/pcZZAfv7Gm2
UrQ63Sax+RSzRuwJA4qJdn4xzjjXd/AJpvnXqtQPf1T4NDj2grQ3XIZZqfLVKImY5HLHKdP5w70c
GQjCylJPN4mVoFYFhv+kKzPIwLH6pPz95X74gYAyEIuuw+NnNWChCIYbZgXbhJRSiROoXGm/1c3o
+6Cmmj4ojFxQ6plRGo+oagxSZ/9SbiD3CoUtBMTENwbkq02DnUIDuoxMYOQrWRJHpHzYHfNpisgy
E06HS/HIhCzalQEVvRRc6TxKVZLFIfxVtOnnJhunMPMoOIm9JjbEcEleXxzfqwAusHDzvDowBkIj
LfhUpp3iZbjwHgjPUbjLkWFVqinK55tKLc9Fzt+ZTk9KJjqpvgolqXXzfmrjxXeS8lg9nLrN7oxq
3cOFXDi9n438F/n5VBDL7FxawOT3aPvj5mU8NTXveR/eUk33GGsko9PwieP6CR02E7R85MJGJSPn
lKw5Po2VgdkAGYFB35x9CcnoxrPZV1CX4q4frt6eo/pvmpsOsuBwldYyw8XRK0xeDASAeZe3Qidy
C9YWBS5gz+1bBJluVzukwwKqKW/SFwQNElxUJdBrfCP/yyK2cy3AaqyhHJG6Qh6PlC6acy/yXWh8
d29NrqOBTvd7lMTAIs2kc2tbMGId1dI7hq4n2v5BWpgoVUW51RcyNK6s9vKRwPGn3DvFpNXAhhri
lUAaE061Jdwbllw+YipVTlF6WuoruB4ZEeqcpVNDsK1qWzdU+uU79g/zEpTlLLE+jZE1o+frJE9k
8/o+peskoO/pT4d0IJBVALEAAACuAQAAAuJahV+muodHHTMwACAAAABMdHRuZ19kZXZfbWFpbGlu
Z19zY3JpcHRzXHJlcG9ydF9sdHRuZ19zY3JpcHQuc2gAsDuVcQmZEQj9lBE3S+FXFdqTyJpgPEUd
DI2rgLimXmTwB7xNEgyRQiSEkIOhJuvTZfhX//I6oKKCqCitnwfcHbx5NiE18JygiMXxd6jmYYNY
LlJIDWKn7mq7YEaADfKiYhWphBFQGKkxhZwGoZFFSMy1pksYU0PGLod3eb/MnMovPXD30xkZooTg
p270DbZw2Tkr7B/SmGv370Z8Cr/qjXOftrq1aYGsAwPqjmLxx7eK0MgDkmFadCCQTwCxAAAAKgEA
AAK8fgs3qbqHRx0zKgAgAAAATHR0bmdfZGV2X21haWxpbmdfc2NyaXB0c1xyZXBvcnRfc2NyaXB0
LnNoALDUXFANlREIvZgRNxfCrIZoCEI/jaxOIsdArg5kiYEwBWRXu7oYjEBzEmZGQeCXpu6qrqrl
8h9Kqe9wL7T9wh53JsOizkpMB5R1DF6CZh16AqMVADYJm9mlZgSnAORj8CjUmsobp1reSK5tOdoc
N9xRFHW7VkR65Bqv45lPF2mntL0dUztjVffXwhhGCDEpRSMlfMeo70loZGYKLjhfxEyjHGv4Bxz+
zXuIK0FN/Sm/N/pgd0AnbXTgkD4AAAAAAAAAAAACAAAAALG6h0cUMBkAEAAAAEx0dG5nX2Rldl9t
YWlsaW5nX3NjcmlwdHMAsDgzN8Q9ewBABwA=
--001a11c3787ab26586052652ba82
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--001a11c3787ab26586052652ba82--
