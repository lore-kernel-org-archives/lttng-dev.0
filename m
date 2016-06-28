From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: subbuffers count and size
Date: Tue, 28 Jun 2016 13:38:33 +0000 (UTC)
Message-ID: <364174435.50772.1467121113768.JavaMail.zimbra__32254.0786503398$1467121155$gmane$org@efficios.com>
References: <CAHxF_R85MSZ5LqvH1JGUXyj2HaMNfyO7pT7ypQ=o=zoE1F4ybw@mail.gmail.com>
 <5771452E.6070509@gydle.com>
 <CAHxF_R9gUJhe3Tqv=Ju=GG4Oi+E44JwpP5dRCiKGtJ4x01BEBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2566170270628639910=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 6BD8AA1F8D
 for <lttng-dev@lists.lttng.org>; Tue, 28 Jun 2016 13:38:47 +0000 (UTC)
In-Reply-To: <CAHxF_R9gUJhe3Tqv=Ju=GG4Oi+E44JwpP5dRCiKGtJ4x01BEBA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Vijay Anand <vjanandr85@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2566170270628639910==
Content-Type: multipart/alternative;
	boundary="----=_Part_50771_1907987092.1467121113767"

------=_Part_50771_1907987092.1467121113767
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jun 28, 2016, at 3:14 AM, Vijay Anand <vjanandr85@gmail.com> wrote: 

> Hi Sebastien,

> I have written a simple program with a loop 1 million times adding a trace
> everytime.

1 million times is not that many events. The startup time of your 
application, and buffer setup time will not be negligible, and should 
be subtracted. 

> Please find the simple program at
> https://github.com/vjanandr/sampleC/blob/master/lttng/benchmark/lttng_benchmark.c

> I first configured the channel and then ran the benchmark program.
> More logs @ https://gist.github.com/vjanandr/1db6a6a9d93e6b3f2ac30a05aadcf06b

> Here is the observation below:

> a. default 4 subbuffers with 128K each takes 1894063 microseconds
> b. 16 subbuffers with 1024K each takes 1882392 microseconds
> b. 16 subbuffer with 2M each takes 1884999 microseconds

You vary 2 variables (at least there): sub-buffer size, and overall buffer size. 

Larger sub-buffers means you reach sub-buffer boundaries less often (faster). 
Larger buffers means you trash extra L1/L2/L3 cache on your CPU (slower). 

So the 2 variables you vary here affect performance in opposite ways. 

> on an average the programs takes about 1.8 seconds for each run.

> Is this expected ?, if I have to improve the performance should I configure
> anything different ?

You should detail your system config (kernel version, kernel configuration, 
architecture, cpu speed, amount of memory) whenever you present a benchmark, 
otherwise it is meaningless. 

You should also benchmark separately flight recorder tracing (snapshot) 
and tracing doing I/O to disk or network (discard mode). You should keep 
track of discarded event counts in your results. 

You should also benchmark separately transient state tracing (e.g. tracing 
for the first time into buffers) vs steady-state tracing (after the cache lines 
and TLB entries are hot). 

> Just that I understand this better, I have been trying to understand this from
> looking at the code. Could you please point me to the code that might be
> impacting this ?

You might want to look at those slides for methodology ideas: 

http://hsdm.dorsal.polymtl.ca/may2016_mgebai 

Thanks, 

Mathieu 

> Regards,
> Vijay

> On Mon, Jun 27, 2016 at 8:54 PM, Sebastien Boisvert < sboisvert@gydle.com >
> wrote:

>> Hi Vijay,

>> On 06/27/2016 06:12 AM, Vijay Anand wrote:
>> > Hi,

>>> I have been trying to understand the impact of performance while logging user
>> > space program based on the subbuffer count and size.


>> The sub-buffers count and size is well-documented here:

>> http://lttng.org/docs/#doc-channel-subbuf-size-vs-subbuf-count

>> > I have a simple program logging 1 million traces

>> Do you mean that you recorded 1 million UST events ?

>> Or do you mean that you traced your app 1 million times and you generated 1
>> million traces ?

>>> and I dont seem to see any appreciable performance between the below two
>> > configurations.

>> > a. default 4 subbufers 128KB each
>> > b. 16 subbufers with 1024kB each.

>> When you are enabling your UST events (before starting the LTTng session),
>> are you enabling your UST events in your custom channel (the one with
>> configuration a. or configuration b.) ?

>> If not, it could explain the lack of difference in performance between your 2
>> configurations.

>> Example:

>> lttng create

>> lttng enable-channel -u --subbuf-size 4M channel7
>> lttng enable-event -u -c channel7 gydle_om:Allocator_constructor_default

>> lttng start

>> run-your-app

>> lttng stop
>> lttng view > trace.txt


>>> Moreover I have been looking at the lttng-ust code to understand the performance
>> > impacts from the implementation and unable to comprehend what is documented at

>> > http://lttng.org/docs/#doc-channel-subbuf-size-vs-subbuf-count

>>> I see that channel_backend_init, _shm_object_table_alloc_shm seems to allocate
>>> one big shared memory chunk which again is subdivided into subbuffers with each
>> > subbuffer referenced using the subbufer index.

>>> Further more lib_ring_buffer_write seems to find the subbuffer index and write
>> > "len" number of bytes into the subbuffer index.

>>> Could anyone please enlighten me what is the overhead involved while switching
>> > from one subbufer to another as documented.


>> The documentation indicates that the tracer's CPU overhead is caused by 2
>> things:

>> 1) marking the current sub-buffer as consumable, and
>> 2) switching to an empty sub-buffer.

>> > Regards,
>> > Vijay


>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_50771_1907987092.1467121113767
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jun 28, 2016, at 3:14 AM, Vijay Anand &lt;vjanandr85@gmail.com=
&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div clas=
s=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:small=
"><span style=3D"color: #000000;" data-mce-style=3D"color: #000000;" color=
=3D"#000000">Hi Sebastien,</span></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D"color: #=
000000;" data-mce-style=3D"color: #000000;" color=3D"#000000"><br></span></=
div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;fo=
nt-size:small"><span style=3D"color: #000000;" data-mce-style=3D"color: #00=
0000;" color=3D"#000000">I have written a simple program with a loop 1 mill=
ion times adding a trace everytime.</span></div></div></blockquote><div><br=
></div><div>1 million times is not that many events. The startup time of yo=
ur<br data-mce-bogus=3D"1"></div><div>application, and buffer setup time wi=
ll not be negligible, and should</div><div>be subtracted.<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"borde=
r-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=3D"gmail_defau=
lt" style=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D=
"color: #000000;" data-mce-style=3D"color: #000000;" color=3D"#000000">Plea=
se find the simple program at&nbsp;<a href=3D"https://github.com/vjanandr/s=
ampleC/blob/master/lttng/benchmark/lttng_benchmark.c" target=3D"_blank">htt=
ps://github.com/vjanandr/sampleC/blob/master/lttng/benchmark/lttng_benchmar=
k.c</a></span><br data-mce-bogus=3D"1"></div><div class=3D"gmail_default" s=
tyle=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D"colo=
r: #000000;" data-mce-style=3D"color: #000000;" color=3D"#000000"><br></spa=
n></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-seri=
f;font-size:small"><span style=3D"color: #000000;" data-mce-style=3D"color:=
 #000000;" color=3D"#000000">I first configured the channel and then ran th=
e benchmark program.</span></div><div class=3D"gmail_default" style=3D"font=
-family:verdana,sans-serif;font-size:small"><span style=3D"color: #000000;"=
 data-mce-style=3D"color: #000000;" color=3D"#000000">More logs @&nbsp;<a h=
ref=3D"https://gist.github.com/vjanandr/1db6a6a9d93e6b3f2ac30a05aadcf06b" t=
arget=3D"_blank">https://gist.github.com/vjanandr/1db6a6a9d93e6b3f2ac30a05a=
adcf06b</a></span><br data-mce-bogus=3D"1"></div><div class=3D"gmail_defaul=
t" style=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D"=
color: #000000;" data-mce-style=3D"color: #000000;" color=3D"#000000"><br><=
/span></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-=
serif;font-size:small"><span style=3D"color: #000000;" data-mce-style=3D"co=
lor: #000000;" color=3D"#000000">Here is the observation below:</span></div=
><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-=
size:small"><span style=3D"color: #000000;" data-mce-style=3D"color: #00000=
0;" color=3D"#000000"><br></span></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D"color: #=
000000;" data-mce-style=3D"color: #000000;" color=3D"#000000">a. default 4 =
subbuffers with 128K each takes 1894063 microseconds</span></div><div class=
=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:small"=
><span style=3D"color: #000000;" data-mce-style=3D"color: #000000;" color=
=3D"#000000">b. 16 subbuffers with 1024K each takes 1882392 microseconds</s=
pan></div><div class=3D"gmail_default" style=3D""><span style=3D"color: #00=
0000;" data-mce-style=3D"color: #000000;" color=3D"#000000"><span style=3D"=
font-family: verdana,sans-serif;" data-mce-style=3D"font-family: verdana,sa=
ns-serif;" face=3D"verdana, sans-serif">b. 16 subbuffer with 2M each takes =
1884999 microseconds</span></span></div></div></blockquote><div><br></div><=
div>You vary 2 variables (at least there): sub-buffer size, and overall buf=
fer size.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div>Larger sub-buffers means you reach sub-buffer boundaries less often (=
faster).<br data-mce-bogus=3D"1"></div><div>Larger buffers means you trash =
extra L1/L2/L3 cache on your CPU (slower).<br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div>So the 2 variables you vary here aff=
ect performance in opposite ways.<br data-mce-bogus=3D"1"></div><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=
=3D"gmail_default" style=3D""><span style=3D"color: #000000;" data-mce-styl=
e=3D"color: #000000;" color=3D"#000000"><br></span></div><div class=3D"gmai=
l_default" style=3D"font-family:verdana,sans-serif;font-size:small"><span s=
tyle=3D"color: #000000;" data-mce-style=3D"color: #000000;" color=3D"#00000=
0"><br></span></div><div class=3D"gmail_default" style=3D"font-family:verda=
na,sans-serif;font-size:small"><span style=3D"color: #000000;" data-mce-sty=
le=3D"color: #000000;" color=3D"#000000">on an average the programs takes a=
bout 1.8 seconds for each run.</span></div><div class=3D"gmail_default" sty=
le=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D"color:=
 #000000;" data-mce-style=3D"color: #000000;" color=3D"#000000"><br></span>=
</div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;=
font-size:small"><span style=3D"color: #000000;" data-mce-style=3D"color: #=
000000;" color=3D"#000000">Is this expected ?, if I have to improve the per=
formance should I configure anything different ?</span></div></div></blockq=
uote><div><br></div><div>You should detail your system config (kernel versi=
on, kernel configuration,<br data-mce-bogus=3D"1"></div><div>architecture, =
cpu speed, amount of memory) whenever you present a benchmark,<br data-mce-=
bogus=3D"1"></div><div>otherwise it is meaningless.<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>You should also benchmark s=
eparately flight recorder tracing (snapshot)<br data-mce-bogus=3D"1"></div>=
<div>and tracing doing I/O to disk or network (discard mode). You should ke=
ep<br data-mce-bogus=3D"1"></div><div>track of discarded event counts in yo=
ur results.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></d=
iv><div>You should also benchmark separately transient state tracing (e.g. =
tracing<br data-mce-bogus=3D"1"></div><div>for the first time into buffers)=
 vs steady-state tracing (after the cache lines<br data-mce-bogus=3D"1"></d=
iv><div>and TLB entries are hot).<br data-mce-bogus=3D"1"></div><div><br da=
ta-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family=
:verdana,sans-serif;font-size:small"><span style=3D"color: #000000;" data-m=
ce-style=3D"color: #000000;" color=3D"#000000"><br></span></div><div class=
=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:small"=
><span style=3D"color: #000000;" data-mce-style=3D"color: #000000;" color=
=3D"#000000">Just that I understand this better, I have been trying to unde=
rstand this from looking at the code. Could you please point me to the code=
 that might be impacting this ?</span></div></div></blockquote><div><br></d=
iv><div>You might want to look at those slides for methodology ideas:<br da=
ta-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>http://hs=
dm.dorsal.polymtl.ca/may2016_mgebai</div><div><br data-mce-bogus=3D"1"></di=
v><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D=
"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5p=
x;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-dec=
oration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div c=
lass=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gmail_signature">=
<div dir=3D"ltr"><span style=3D"color: #0000ff; font-family: verdana,sans-s=
erif;" data-mce-style=3D"color: #0000ff; font-family: verdana,sans-serif;" =
color=3D"#0000ff" face=3D"verdana, sans-serif">Regards,</span><div><span st=
yle=3D"color: #0000ff; font-family: verdana,sans-serif;" data-mce-style=3D"=
color: #0000ff; font-family: verdana,sans-serif;" color=3D"#0000ff" face=3D=
"verdana, sans-serif">Vijay</span></div></div></div></div><br><div class=3D=
"gmail_quote">On Mon, Jun 27, 2016 at 8:54 PM, Sebastien Boisvert <span dir=
=3D"ltr">&lt;<a href=3D"mailto:sboisvert@gydle.com" target=3D"_blank">sbois=
vert@gydle.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi V=
ijay,<br><span class=3D""><br>
<br>
On 06/27/2016 06:12 AM, Vijay Anand wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I have been trying to understand the impact of performance while loggi=
ng user space program based on the subbuffer count and size.<br>
&gt;<br>
<br>
</span>The sub-buffers count and size is well-documented here:<br><br><a hr=
ef=3D"http://lttng.org/docs/#doc-channel-subbuf-size-vs-subbuf-count" rel=
=3D"noreferrer" target=3D"_blank">http://lttng.org/docs/#doc-channel-subbuf=
-size-vs-subbuf-count</a><br><span class=3D""><br>
<br>
<br>
&gt; I have a simple program logging 1 million traces<br>
<br>
</span>Do you mean that you recorded 1 million UST events ?<br><br>
Or do you mean that you traced your app 1 million times and you generated 1=
 million traces ?<br><span class=3D""><br>
<br>
&gt; and I dont seem to see any appreciable performance between the below t=
wo configurations.<br>
&gt;<br>
&gt; a. default 4 subbufers 128KB each<br>
&gt; b. 16 subbufers with 1024kB each.<br>
<br>
</span>When you are enabling your UST events (before starting the LTTng ses=
sion),<br>
are you enabling your UST events in your custom channel (the one with confi=
guration a. or configuration b.) ?<br><br><br>
If not, it could explain the lack of difference in performance between your=
 2 configurations.<br><br><br>
Example:<br><br>
&nbsp; &nbsp; lttng create<br><br>
&nbsp; &nbsp; lttng enable-channel -u --subbuf-size 4M channel7<br>
&nbsp; &nbsp; lttng enable-event -u -c channel7 gydle_om:Allocator_construc=
tor_default<br><br>
&nbsp; &nbsp; lttng start<br><br>
&nbsp; &nbsp; run-your-app<br><br>
&nbsp; &nbsp; lttng stop<br>
&nbsp; &nbsp; lttng view &gt; trace.txt<br><span class=3D""><br>
<br>
<br>
&gt;<br>
&gt; Moreover I have been looking at the lttng-ust code to understand the p=
erformance impacts from the implementation and unable to comprehend what is=
 documented at<br>
&gt;<br>
&gt; <a href=3D"http://lttng.org/docs/#doc-channel-subbuf-size-vs-subbuf-co=
unt" rel=3D"noreferrer" target=3D"_blank">http://lttng.org/docs/#doc-channe=
l-subbuf-size-vs-subbuf-count</a><br>
&gt;<br>
&gt; I see that channel_backend_init, _shm_object_table_alloc_shm seems to =
allocate one big shared memory chunk which again is subdivided into subbuff=
ers with each subbuffer referenced using the subbufer index.<br>
&gt;<br>
&gt; Further more lib_ring_buffer_write seems to find the subbuffer index a=
nd write "len" number of bytes into the subbuffer index.<br>
&gt;<br>
&gt; Could anyone please enlighten me what is the overhead involved while s=
witching from one subbufer to another as documented.<br>
&gt;<br>
<br>
</span>The documentation indicates that the tracer's CPU overhead is caused=
 by 2 things:<br><br>
1) marking the current sub-buffer as consumable, and<br>
2) switching to an empty sub-buffer.<br><br><br><br><br>
&gt; Regards,<br>
&gt; Vijay<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
&gt;<br></blockquote></div><br></div><br>__________________________________=
_____________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>htt=
ps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></d=
iv><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathi=
eu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body>=
</html>
------=_Part_50771_1907987092.1467121113767--

--===============2566170270628639910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2566170270628639910==--
