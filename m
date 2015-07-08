From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Create channel error resolved
Date: Wed, 8 Jul 2015 17:42:56 -0400
Message-ID: <CA+jJMxsc4LodARoCCT5CRvmyN+Q7b+QgLq1GMPERv+sq-zNfFw__8600.7117563442$1436391844$gmane$org@mail.gmail.com>
References: <SN1PR12MB0319A4CF7ED35B7D250426BC9B930@SN1PR12MB0319.namprd12.prod.outlook.com>
 <CA+jJMxs9SYDJpYyk8jMxRGfxZ1SzaBQbmqkA5dNFOvELJ1N40Q@mail.gmail.com>
 <SN1PR12MB03190B1482175C51A50586249B920@SN1PR12MB0319.namprd12.prod.outlook.com>
 <SN1PR12MB0319E6C9EB60A3165E259BD99B920@SN1PR12MB0319.namprd12.prod.outlook.com>
 <CA+jJMxs-379mROWBkiYxCZCc6J_GzC92TZzA8Ewpb+oHus1MTw@mail.gmail.com>
 <SN1PR12MB031997C0AB4ACEDCF5AC41429B920@SN1PR12MB0319.namprd12.prod.outlook.com>
 <CA+jJMxsABJw=EQjP9NoLRVQu+yKdSKdneM9PQc2NtC0nCiYK2w@mail.gmail.com>
 <125a2ce0-512c-4757-873f-8288d9f41545@typeapp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1395263245=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZCx7O-0007w5-Be
 for lttng-dev@lists.lttng.org; Wed, 08 Jul 2015 17:43:09 -0400
Received: by pddu5 with SMTP id u5so64928354pdd.3
 for <lttng-dev@lists.lttng.org>; Wed, 08 Jul 2015 14:42:56 -0700 (PDT)
In-Reply-To: <125a2ce0-512c-4757-873f-8288d9f41545@typeapp.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dylan <dilong.zheng@mitel.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1395263245==
Content-Type: multipart/alternative; boundary=047d7b162bc599307f051a6405b4

--047d7b162bc599307f051a6405b4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Good to hear, thanks!

J=C3=A9r=C3=A9mie

On Wed, Jul 8, 2015 at 5:27 PM, Dylan <dilong.zheng@mitel.com> wrote:

> Hello Jeremie,
>
> So I uninstalled lttng-ust and reinstalled it using my package manager an=
d
> the error I was getting seemed to be gone (I am able to enable the user
> events without a create channel error now).
>
> Thanks,
>
> Dilong
> On Jul 8, 2015, at 5:10 PM, "J=C3=A9r=C3=A9mie Galarneau" <
> jeremie.galarneau@efficios.com> wrote:
>>
>>  Can you test whether or not you can reproduce this using the latest 2.5
>> release (lttng-tools 2.5.4 + lttng-ust 2.5.5)?
>>  J=C3=A9r=C3=A9mie
>>
>>  On Tue, Jul 7, 2015 at 2:23 PM, Dilong Zheng <Dilong.Zheng@mitel.com>
>> wrote:
>>
>>>  Hi,
>>>
>>> I'm using *LTTng v2.5.1 - Fumisterie*.
>>>
>>> I launched the session daemon manually using: lttng-sessiond -vvv and
>>> attempted to enable my UST events in another terminal (unsuccessfully).=
 I
>>> have attached the contents of the sessiond log (please see
>>> *sessiondlog.txt*).
>>>
>>> Thanks,
>>>
>>> Dilong
>>>
>>>  ------------------------------
>>>  *From:* jeremie.galarneau@gmail.com <jeremie.galarneau@gmail.com> on
>>> behalf of J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
>>> *Sent:* Tuesday, July 7, 2015 1:13 PM
>>>
>>> *To:* Dilong Zheng
>>> *Cc:* lttng-dev@lists.lttng.org
>>> *Subject:* Re: [lttng-dev] UST Create Channel Failed, Why?
>>>
>>>    Which release of 2.5 are you using? You can find out using:
>>> $ lttng version
>>>
>>>  Can you launch the session daemon manually in verbose-mode and provide
>>> the logs?
>>>  $ lttng-sessiond -vvv
>>>
>>>  and enable your events in another terminal.
>>>
>>>  Thanks,
>>>  J=C3=A9r=C3=A9mie
>>>
>>>
>>>  On Tue, Jul 7, 2015 at 11:28 AM, Dilong Zheng <Dilong.Zheng@mitel.com>
>>> wrote:
>>>
>>>>  Hi Jeremie,
>>>>
>>>>
>>>>  Had some grammatical mistakes in my last email.... this should be
>>>> clearer.
>>>>
>>>>
>>>>  I am using LTTng v2.5. I am not explicitly creating any channels. I
>>>> am only creating a session via: lttng create [session-name] . I used
>>>> to always just create a session and then enable whichever available us=
er
>>>> tracepoint that I need (without explicitly creating any channels).
>>>>
>>>>
>>>>  Thanks,
>>>>
>>>>
>>>>  Dilong
>>>>
>>>>
>>>>  ------------------------------
>>>>  *From:* Dilong Zheng
>>>> *Sent:* Tuesday, July 7, 2015 11:26 AM
>>>> *To:* J=C3=A9r=C3=A9mie Galarneau
>>>>
>>>> *Cc:* lttng-dev@lists.lttng.org
>>>> *Subject:* Re: [lttng-dev] UST Create Channel Failed, Why?
>>>>
>>>>
>>>> Hi Jeremie,
>>>>
>>>>
>>>>  I am using LTTng v2.5. I am not explicitly creating channels. I am
>>>> only creating a session: lttng create [session-name] . It used to
>>>> always just create a session and then enable whichever available user
>>>> tracepoint that I need (which out explicitly creating any channels).
>>>>
>>>>
>>>>  Thanks,
>>>>
>>>>
>>>>  Dilong
>>>>
>>>>  ------------------------------
>>>>  *From:* jeremie.galarneau@gmail.com <jeremie.galarneau@gmail.com> on
>>>> behalf of J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
>>>> *Sent:* Tuesday, July 7, 2015 11:20 AM
>>>> *To:* Dilong Zheng
>>>> *Cc:* lttng-dev@lists.lttng.org
>>>> *Subject:* Re: [lttng-dev] UST Create Channel Failed, Why?
>>>>
>>>>   Hi Dilong,
>>>>
>>>>  How do you create this channel and using which version of LTTng?
>>>>
>>>>  J=C3=A9r=C3=A9mie
>>>>
>>>>  On Mon, Jul 6, 2015 at 2:11 PM, Dilong Zheng <Dilong.Zheng@mitel.com>
>>>> wrote:
>>>>
>>>>>  Hi all,
>>>>>
>>>>>
>>>>>  While trying to enable UST events, I get the following error message=
:
>>>>>
>>>>>
>>>>>  Error: Event mitel:sem_wait_entry: UST create channel failed
>>>>> (channel channel0, session mcdUST3)
>>>>>
>>>>>
>>>>>  When I type: lttng list -u I am able to see a list of all my UST
>>>>> tracepoints.
>>>>>
>>>>> Could someone please provide some insight as to why this error is
>>>>> appearing and steps I could take to fix this error. Thanks.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>
>>>>>
>>>>
>>>>
>>>>  --
>>>>  J=C3=A9r=C3=A9mie Galarneau
>>>> EfficiOS Inc.
>>>> http://www.efficios.com
>>>>
>>>
>>>
>>>
>>>  --
>>>  J=C3=A9r=C3=A9mie Galarneau
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>
>>
>>
>> --
>>  J=C3=A9r=C3=A9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7b162bc599307f051a6405b4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good to hear, thanks!<div><br></div><div>J=C3=A9r=C3=A9mie=
</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On We=
d, Jul 8, 2015 at 5:27 PM, Dylan <span dir=3D"ltr">&lt;<a href=3D"mailto:di=
long.zheng@mitel.com" target=3D"_blank">dilong.zheng@mitel.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div><p dir=3D"ltr">Hello Jerem=
ie,</p>
<p dir=3D"ltr">So I uninstalled lttng-ust and reinstalled it using my packa=
ge manager and the error I was getting seemed to be gone (I am able to enab=
le the user events without a create channel error now).</p>
<p dir=3D"ltr">Thanks,</p>
<p dir=3D"ltr">Dilong</p>
<div class=3D"gmail_quote">On Jul 8, 2015, at 5:10 PM, &quot;J=C3=A9r=C3=A9=
mie Galarneau&quot; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" t=
arget=3D"_blank">jeremie.galarneau@efficios.com</a>&gt; wrote:<blockquote c=
lass=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr">
 <div>
  Can you test whether or not you can reproduce this using the latest 2.5 r=
elease (lttng-tools 2.5.4 + lttng-ust 2.5.5)?
  <br>
 </div>
 <div>
  J=C3=A9r=C3=A9mie
 </div>
</div>
<div class=3D"gmail_extra">
 <br>
 <div class=3D"gmail_quote">
  On Tue, Jul 7, 2015 at 2:23 PM, Dilong Zheng=20
  <span dir=3D"ltr">&lt;<a href=3D"mailto:Dilong.Zheng@mitel.com" target=3D=
"_blank">Dilong.Zheng@mitel.com</a>&gt;</span> wrote:
  <br>
  <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">=20
   <div dir=3D"ltr">=20
    <div style=3D"font-size:12pt;color:#000000;background-color:#ffffff;fon=
t-family:Calibri,Arial,Helvetica,sans-serif">=20
     <p>Hi,<br> </p>=20
     <br> I&#39;m using=20
     <b>LTTng v2.5.1 - Fumisterie</b>.
     <br>=20
     <br> I launched the session daemon manually using:=20
     <span style=3D"font-family:&quot;Courier New&quot;,monospace"> lttng-s=
essiond -vvv</span>=C2=A0and attempted to enable my UST events in another t=
erminal (unsuccessfully). I have attached the contents of the sessiond log =
(please see=20
     <em>sessiondlog.txt</em>).=20
     <br>=20
     <br> Thanks,
     <br>=20
     <br> Dilong
     <br>=20
     <br>=20
     <div style=3D"color:rgb(46,52,54)">=20
      <hr style=3D"display:inline-block;width:98%">=20
      <div dir=3D"ltr">
       <font style=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D=
"#000000"><span><b>From:</b> <a href=3D"mailto:jeremie.galarneau@gmail.com"=
 target=3D"_blank">jeremie.galarneau@gmail.com</a> &lt;<a href=3D"mailto:je=
remie.galarneau@gmail.com" target=3D"_blank">jeremie.galarneau@gmail.com</a=
>&gt; on behalf of J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremi=
e.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com<=
/a>&gt;<br> </span><b>Sent:</b> Tuesday, July 7, 2015 1:13 PM
        </font><div><font style=3D"font-size:11pt" face=3D"Calibri, sans-se=
rif" color=3D"#000000">
         </font><div><font style=3D"font-size:11pt" face=3D"Calibri, sans-s=
erif" color=3D"#000000">
          <br>=20
          <b>To:</b> Dilong Zheng
          <br>=20
          <b>Cc:</b>=20
          <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lt=
tng-dev@lists.lttng.org</a>
          <br>=20
          <b>Subject:</b> Re: [lttng-dev] UST Create Channel Failed, Why?
         </font></div></div>=20
       <div>
        =C2=A0
       </div>=20
      </div>
      <div>
       <div>=20
        <div>=20
         <div dir=3D"ltr">
          Which release of 2.5 are you using? You can find out using:=20
          <div>
           $ lttng version
          </div>=20
          <div>
           <br>=20
          </div>=20
          <div>
           Can you launch the session daemon manually in verbose-mode and p=
rovide the logs?
          </div>=20
          <div>
           $ lttng-sessiond -vvv
          </div>=20
          <div>
           <br>=20
          </div>=20
          <div>
           and enable your events in another terminal.
          </div>=20
          <div>
           <br>=20
          </div>=20
          <div>
           Thanks,
          </div>=20
          <div>
           J=C3=A9r=C3=A9mie
          </div>=20
          <div>
           <br>=20
          </div>=20
         </div>=20
         <div class=3D"gmail_extra">
          <br>=20
          <div class=3D"gmail_quote">
           On Tue, Jul 7, 2015 at 11:28 AM, Dilong Zheng=20
           <span dir=3D"ltr"> &lt;<a href=3D"mailto:Dilong.Zheng@mitel.com"=
 target=3D"_blank">Dilong.Zheng@mitel.com</a>&gt;</span> wrote:
           <br>=20
           <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">=20
            <div dir=3D"ltr">=20
             <div style=3D"font-size:12pt;color:#000000;background-color:#f=
fffff;font-family:Calibri,Arial,Helvetica,sans-serif">=20
              <p>Hi Jeremie,</p>=20
              <p><br> </p>=20
              <p>Had some grammatical mistakes in my last email.... this sh=
ould be clearer.<br> </p>=20
              <p><br> </p>=20
              <p>I am using LTTng v2.5. I am not explicitly creating any ch=
annels. I am only creating a session via: <span style=3D"font-family:&quot;=
Courier New&quot;,monospace">lttng create [session-name]</span>=C2=A0. I us=
ed to always just create a session and then enable whichever available user=
 tracepoint that I need (without explicitly creating any channels).</p>=20
              <p><br> </p>=20
              <p>Thanks,</p>=20
              <p><br> </p>=20
              <p>Dilong<br style=3D"font-family:&quot;Courier New&quot;,mon=
ospace"> </p>=20
              <br>=20
              <br>=20
              <div style=3D"color:rgb(46,52,54)">=20
               <hr style=3D"display:inline-block;width:98%">=20
               <div dir=3D"ltr">
                <font style=3D"font-size:11pt" face=3D"Calibri, sans-serif"=
 color=3D"#000000"><b>From:</b> Dilong Zheng<br> <b>Sent:</b> Tuesday, July=
 7, 2015 11:26 AM<br> <b>To:</b> J=C3=A9r=C3=A9mie Galarneau=20
                 </font><div><font style=3D"font-size:11pt" face=3D"Calibri=
, sans-serif" color=3D"#000000">=20
                  </font><div><font style=3D"font-size:11pt" face=3D"Calibr=
i, sans-serif" color=3D"#000000">
                   <br>=20
                   <b>Cc:</b>=20
                   <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_=
blank">lttng-dev@lists.lttng.org</a>
                   <br>=20
                   <b>Subject:</b> Re: [lttng-dev] UST Create Channel Faile=
d, Why?
                  </font></div></div>=20
                <div>
                 =C2=A0
                </div>=20
               </div>=20
               <div>=20
                <div>=20
                 <div>=20
                  <div style=3D"font-size:12pt;color:#000000;background-col=
or:#ffffff;font-family:Calibri,Arial,Helvetica,sans-serif">=20
                   <p>Hi Jeremie,</p>=20
                   <p><br> </p>=20
                   <p>I am using LTTng v2.5. I am not explicitly creating c=
hannels. I am only creating a session: <span style=3D"font-family:&quot;Cou=
rier New&quot;,monospace">lttng create [session-name]</span>=C2=A0. It used=
 to always just create a session and then enable whichever available user t=
racepoint that I need (which out explicitly creating any channels).</p>=20
                   <p><br> </p>=20
                   <p>Thanks,</p>=20
                   <p><br> </p>=20
                   <p>Dilong<br style=3D"font-family:&quot;Courier New&quot=
;,monospace"> </p>=20
                   <br>=20
                   <div style=3D"color:rgb(46,52,54)">=20
                    <hr style=3D"display:inline-block;width:98%">=20
                    <div dir=3D"ltr">
                     <font style=3D"font-size:11pt" face=3D"Calibri, sans-s=
erif" color=3D"#000000"><b>From:</b> <a href=3D"mailto:jeremie.galarneau@gm=
ail.com" target=3D"_blank">jeremie.galarneau@gmail.com</a> &lt;<a href=3D"m=
ailto:jeremie.galarneau@gmail.com" target=3D"_blank">jeremie.galarneau@gmai=
l.com</a>&gt; on behalf of J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailt=
o:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@effic=
ios.com</a>&gt;<br> <b>Sent:</b> Tuesday, July 7, 2015 11:20 AM<br> <b>To:<=
/b> Dilong Zheng<br> <b>Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org=
" target=3D"_blank">lttng-dev@lists.lttng.org</a><br> <b>Subject:</b> Re: [=
lttng-dev] UST Create Channel Failed, Why?</font>=20
                     <div>
                      =C2=A0
                     </div>=20
                    </div>=20
                    <div>=20
                     <div dir=3D"ltr">
                      Hi Dilong,=20
                      <div>
                       <br>=20
                      </div>=20
                      <div>
                       How do you create this channel and using which versi=
on of LTTng?
                      </div>=20
                      <div>
                       <br>=20
                      </div>=20
                      <div>
                       J=C3=A9r=C3=A9mie
                      </div>=20
                     </div>=20
                     <div class=3D"gmail_extra">
                      <br>=20
                      <div class=3D"gmail_quote">
                       On Mon, Jul 6, 2015 at 2:11 PM, Dilong Zheng=20
                       <span dir=3D"ltr"> &lt;<a title=3D"Ctrl+Click or tap=
 to follow the link" href=3D"mailto:Dilong.Zheng@mitel.com" target=3D"_blan=
k">Dilong.Zheng@mitel.com</a>&gt;</span> wrote:
                       <br>=20
                       <blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=20
                        <div dir=3D"ltr">=20
                         <div style=3D"font-size:12pt;color:#000000;backgro=
und-color:#ffffff;font-family:Calibri,Arial,Helvetica,sans-serif">=20
                          <p>Hi all,</p>=20
                          <p><br> </p>=20
                          <p>While trying to enable UST events, I get the f=
ollowing error message:</p>=20
                          <p><br> </p>=20
                          <p><span style=3D"font-family:&quot;Courier New&q=
uot;,monospace">Error: Event mitel:sem_wait_entry: UST create channel faile=
d (channel channel0, session mcdUST3)</span></p>=20
                          <p><br> </p>=20
                          <p>When I type: <span style=3D"font-family:&quot;=
Courier New&quot;,monospace"></span><span style=3D"font-family:&quot;Courie=
r New&quot;,monospace">lttng list -u</span> <span style=3D"font-family:Cali=
bri,Arial,Helvetica,sans-serif">I am able to see a list of all my UST trace=
points.</span><br> </p>=20
                          <p>Could someone please provide some insight as t=
o why this error is appearing and steps I could take to fix this error. Tha=
nks.</p>=20
                          <p><br> </p>=20
                          <p><br> <br> </p>=20
                         </div>=20
                        </div>=20
                        <br> ______________________________________________=
_
                        <br> lttng-dev mailing list
                        <br>=20
                        <a href=3D"mailto:lttng-dev@lists.lttng.org" target=
=3D"_blank">lttng-dev@lists.lttng.org</a>
                        <br>=20
                        <a href=3D"http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.=
org/cgi-bin/mailman/listinfo/lttng-dev</a>
                        <br>=20
                        <br>=20
                       </blockquote>=20
                      </div>=20
                      <br>=20
                      <br clear=3D"all">=20
                      <div>
                       <br>=20
                      </div> --=20
                      <br>=20
                      <div>
                       J=C3=A9r=C3=A9mie Galarneau
                       <br> EfficiOS Inc.
                       <br>=20
                       <a href=3D"http://www.efficios.com" target=3D"_blank=
">http://www.efficios.com</a>
                      </div>=20
                     </div>=20
                    </div>=20
                   </div>=20
                  </div>=20
                 </div>=20
                </div>=20
               </div>=20
              </div>=20
             </div>=20
            </div>=20
           </blockquote>=20
          </div>=20
          <br>=20
          <br clear=3D"all"><span class=3D"HOEnZb"><font color=3D"#888888">=
=20
          <div>
           <br>=20
          </div> --=20
          <br>=20
          <div>
           J=C3=A9r=C3=A9mie Galarneau
           <br> EfficiOS Inc.
           <br>=20
           <a href=3D"http://www.efficios.com" target=3D"_blank">http://www=
.efficios.com</a>
          </div>=20
         </font></span></div><span class=3D"HOEnZb"><font color=3D"#888888"=
>=20
        </font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">=
=20
       </font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">
      </font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">
     </font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">=20
    </font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">=20
   </font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">=20
  </font></span></blockquote><span class=3D"HOEnZb"><font color=3D"#888888"=
>
 </font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">
 <br>
 <br clear=3D"all">
 <div>
  <br>
 </div>--=20
 <br>
 <div>
  J=C3=A9r=C3=A9mie Galarneau
  <br>EfficiOS Inc.
  <br>
  <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios=
.com</a>
 </div>=20
</font></span></div></blockquote></div></div></blockquote></div><br><br cle=
ar=3D"all"><div><br></div>-- <br><div class=3D"gmail_signature">J=C3=A9r=C3=
=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" ta=
rget=3D"_blank">http://www.efficios.com</a></div>
</div>

--047d7b162bc599307f051a6405b4--


--===============1395263245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1395263245==--
