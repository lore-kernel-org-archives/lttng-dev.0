From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: Help-lttng-ust-pyhton
Date: Fri, 13 Nov 2015 11:21:28 -0500
Message-ID: <CAF4oYfG6VaGS62MF_D83ojtZVbUo9+7KXr7Y+yUeVsY7eCb-BA__2881.33769431642$1447431758$gmane$org@mail.gmail.com>
References: <20151106225909.Horde.ZKUBbt2vnWaMa-0QDzy6txy@www.imp.polymtl.ca>
 <CA+jJMxvgz2D=ga+7fC4FTdnJ0obQLz1K38G7sUrnuqhCMKXg7g@mail.gmail.com>
 <20151112164332.Horde.29NGfz3UJ4wgzaNFRJRqxf-@www.imp.polymtl.ca>
 <20151112182108.Horde.F8RA5lZI0Cb6x7TqbxzXVzB@www.imp.polymtl.ca>
 <5645FF8C.2080401@efficios.com>
 <20151113154637.Horde.Sp6jqlYe3x3lcfEfnNAF7wW@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0114029937=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f172.google.com ([209.85.223.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1ZxH6U-0003LZ-4q
 for lttng-dev@lists.lttng.org; Fri, 13 Nov 2015 11:21:36 -0500
Received: by ioir85 with SMTP id r85so61443588ioi.1
 for <lttng-dev@lists.lttng.org>; Fri, 13 Nov 2015 08:21:28 -0800 (PST)
In-Reply-To: <20151113154637.Horde.Sp6jqlYe3x3lcfEfnNAF7wW@www.imp.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yves Junior Bationo <yves-junior.bationo@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0114029937==
Content-Type: multipart/alternative; boundary=001a113eea42a2ff6c05246e7378

--001a113eea42a2ff6c05246e7378
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yves,

You might want to enable all the python events via
'lttng enable-event -p -a'.

Cheers!

On Fri, Nov 13, 2015 at 10:46 AM, Yves Junior Bationo <
yves-junior.bationo@polymtl.ca> wrote:

> Hi,
> Adding "logging.basicConfig()" seems to work well. "lttng list -u -a"
> return the list of all python log
> BUT
> after enabling all event trace (lttng enable-event -u -a)
> the trace contain only  "lttng_ust_statedump" event, and not a single
> event from the script (warning,error... )
> THKs!
> Yves
>
> Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com> a =C3=A9cr=
it :
>
>
> Hi Yves,
>>
>> We are currently looking a little bit more into it. It might be an error
>> in the documentation.
>>
>> The example report the same error without the 'import lttngust'. If you
>> use python 3 it seems to work.
>>
>> This seems related to the logging.basicConfig() which provide as basic
>> configuration for the root handler. See [1] for more info.
>>
>> For now you can simply add the logging.basicConfig() before everything.
>> I'm not sure if this is a workaround or simply how logging in python
>> works in general.
>>
>> Cheers!
>>
>> [1] https://docs.python.org/2/library/logging.html#logging.basicConfig
>>
>> On 2015-11-12 01:21 PM, Yves Junior Bationo wrote:
>>
>>> I installed liblttng-ust-dev from ppa:lttng/ppa
>>> lttng version: (LTTng Trace Control) 2.7.0 - Herbe =C3=A0 D=C3=A9tourne
>>>
>>> Yves Junior Bationo <yves-junior.bationo@polymtl.ca> a =C3=A9crit :
>>>
>>> Hi, i my script i just change "my-logger" by "hello-logger" (hello.py i=
n
>>>> attachment).
>>>> I try to figure out the probem by
>>>>        export LTTNG_UST_PYTHON_DEBUG=3D1
>>>> and i found this:
>>>> #####
>>>> [0.019155] LTTng-UST debug: <module>(): debug is enabled
>>>> [0.024447] LTTng-UST debug: _init_threads(): entering
>>>> [0.024710] LTTng-UST debug: _get_port_from_file(): reading port from
>>>> file "/var/run/lttng/agent.port"
>>>> [0.025745] LTTng-UST debug: _get_port_from_file(): reading port from
>>>> file "/root/.lttng/agent.port"
>>>> [0.025942] LTTng-UST debug: _init_threads(): system session daemon
>>>> port: 5345
>>>> [0.026117] LTTng-UST debug: _init_threads(): user session daemon port:
>>>> None
>>>> [0.026280] LTTng-UST debug: _init_threads(): creating system client
>>>> thread
>>>> [0.026762] LTTng-UST debug: _init_threads(): created and started syste=
m
>>>> client thread
>>>> [0.026973] LTTng-UST debug: _init_threads(): waiting for registration
>>>> done (expecting 1, timeout is 5.0 s)
>>>> [0.027721] LTTng-UST debug: _client_thread_target(): creating client
>>>> "system" using TCP port 5345
>>>> [0.029745] LTTng-UST debug: _client_thread_target(): starting client
>>>> "system"
>>>> [0.029896] LTTng-UST debug: run(): client "system": connecting to
>>>> session daemon
>>>> [0.030117] LTTng-UST debug: run(): client "system": registering to
>>>> session daemon
>>>> [0.030370] LTTng-UST debug: _recv_server_cmd_header(): client "system"=
:
>>>> received empty server command header
>>>> [0.030532] LTTng-UST debug: _handle_server_cmd(): client "system": bad
>>>> server command
>>>> [0.030667] LTTng-UST debug: run(): client "system": got exception:
>>>> 'module' object has no attribute '_ClientCmdReply'
>>>> ####
>>>> You can see 'bad server command' and 'exception' in the last lines.
>>>>
>>>> J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> a =C3=A9c=
rit :
>>>>
>>>> 2015-11-06 17:59 GMT-05:00 Yves Junior Bationo <
>>>>> yves-junior.bationo@polymtl.ca>:
>>>>>
>>>>>>
>>>>>> j'ai un souci avec lltngust pour les application python
>>>>>> Pour l'exemple de la Doc
>>>>>>       https://lttng.org/docs/#doc-python-application
>>>>>> j'ai l'erreur:
>>>>>>       No handlers could be found for logger "hello-logger"
>>>>>>
>>>>>>
>>>>> Hi Yves,
>>>>>
>>>>> We try to stick to English on this mailing list so the questions and
>>>>> answers remain easily searchable.
>>>>>
>>>>> The example in the docs uses "time" without importing it, I have sent
>>>>> a Pull Request to address that.
>>>>> However, addressing the problem you are encountering, where does
>>>>> "hello-logger" come from?
>>>>>
>>>>> Can you post the code and versions of the components you are using?
>>>>>
>>>>> Thanks,
>>>>> J=C3=A9r=C3=A9mie
>>>>>
>>>>>
>>>>> la commande "lttng list -u -a" me retourne bien la liste des trace
>>>>>> point:
>>>>>>
>>>>>>       PID: 5228 - Name: python
>>>>>>     lttng_python:event (loglevel: TRACE_DEBUG_LINE (13)) (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (typ=
e:
>>>>>> tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE
>>>>>> (13))
>>>>>> (type: tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (loglevel:
>>>>>> TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEBUG_UNIT
>>>>>> (11))
>>>>>> (type: tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglevel:
>>>>>> TRACE_DEBUG_MODULE
>>>>>> (10)) (type: tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_DEBUG_PROCESS (loglevel:
>>>>>> TRACE_DEBUG_PROCESS
>>>>>> (9)) (type: tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel:
>>>>>> TRACE_DEBUG_PROGRAM
>>>>>> (8)) (type: tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel:
>>>>>> TRACE_DEBUG_SYSTEM
>>>>>> (7)) (type: tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_INFO (loglevel: TRACE_INFO (6)) (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_NOTICE (loglevel: TRACE_NOTICE (5))
>>>>>> (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_WARNING (loglevel: TRACE_WARNING (4))
>>>>>> (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_CRIT (loglevel: TRACE_CRIT (2)) (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_ALERT (loglevel: TRACE_ALERT (1)) (type=
:
>>>>>> tracepoint)
>>>>>>     lttng_ust_tracelog:TRACE_EMERG (loglevel: TRACE_EMERG (0)) (type=
:
>>>>>> tracepoint)
>>>>>>     lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_statedump:end (loglevel: TRACE_DEBUG_LINE (13)) (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_statedump:debug_link (loglevel: TRACE_DEBUG_LINE (13))
>>>>>> (type: tracepoint)
>>>>>>     lttng_ust_statedump:build_id (loglevel: TRACE_DEBUG_LINE (13))
>>>>>> (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13))
>>>>>> (type:
>>>>>> tracepoint)
>>>>>>     lttng_ust_statedump:start (loglevel: TRACE_DEBUG_LINE (13)) (typ=
e:
>>>>>> tracepoint)
>>>>>>
>>>>>> Mais pas de resultats dans le repertoire des evenements lorsque
>>>>>> j'active le
>>>>>> tracage lttng.
>>>>>>
>>>>>> Resum=C3=A9
>>>>>>       Probleme 1 :No handlers could be found for logger
>>>>>>               je croyais que "import lttngust" devait gerer cette
>>>>>> situation
>>>>>>
>>>>>>       Probleme 2: pas de resultats au tracage
>>>>>> Merci.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> lttng-dev mailing list
>>>>>> lttng-dev@lists.lttng.org
>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> J=C3=A9r=C3=A9mie Galarneau
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com
>>>>>
>>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>
>> --
>> Jonathan R. Julien
>> Efficios
>>
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
Jonathan Rajotte Julien

--001a113eea42a2ff6c05246e7378
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Yves,<div><br></div><div>You might want to enable all t=
he python events via=C2=A0</div><div>&#39;lttng enable-event -p -a&#39;.</d=
iv><div><br></div><div>Cheers!</div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Fri, Nov 13, 2015 at 10:46 AM, Yves Junior Bati=
ono <span dir=3D"ltr">&lt;<a href=3D"mailto:yves-junior.bationo@polymtl.ca"=
 target=3D"_blank">yves-junior.bationo@polymtl.ca</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
Adding &quot;logging.basicConfig()&quot; seems to work well. &quot;lttng li=
st -u -a&quot; return the list of all python log<br>
BUT<br>
after enabling all event trace (lttng enable-event -u -a)<br>
the trace contain only=C2=A0 &quot;lttng_ust_statedump&quot; event, and not=
 a single event from the script (warning,error... )<br>
THKs!<br>
Yves<br>
<br>
Jonathan Rajotte Julien &lt;<a href=3D"mailto:Jonathan.rajotte-julien@effic=
ios.com" target=3D"_blank">Jonathan.rajotte-julien@efficios.com</a>&gt; a =
=C3=A9crit=C2=A0:<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Yves,<br>
<br>
We are currently looking a little bit more into it. It might be an error in=
 the documentation.<br>
<br>
The example report the same error without the &#39;import lttngust&#39;. If=
 you use python 3 it seems to work.<br>
<br>
This seems related to the logging.basicConfig() which provide as basic conf=
iguration for the root handler. See [1] for more info.<br>
<br>
For now you can simply add the logging.basicConfig() before everything.<br>
I&#39;m not sure if this is a workaround or simply how logging in python wo=
rks in general.<br>
<br>
Cheers!<br>
<br>
[1] <a href=3D"https://docs.python.org/2/library/logging.html#logging.basic=
Config" rel=3D"noreferrer" target=3D"_blank">https://docs.python.org/2/libr=
ary/logging.html#logging.basicConfig</a><br>
<br>
On 2015-11-12 01:21 PM, Yves Junior Bationo wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I installed liblttng-ust-dev from ppa:lttng/ppa<br>
lttng version: (LTTng Trace Control) 2.7.0 - Herbe =C3=A0 D=C3=A9tourne<br>
<br>
Yves Junior Bationo &lt;<a href=3D"mailto:yves-junior.bationo@polymtl.ca" t=
arget=3D"_blank">yves-junior.bationo@polymtl.ca</a>&gt; a =C3=A9crit :<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi, i my script i just change &quot;my-logger&quot; by &quot;hello-logger&q=
uot; (hello.py in attachment).<br>
I try to figure out the probem by<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0export LTTNG_UST_PYTHON_DEBUG=3D1<br>
and i found this:<br>
#####<br>
[0.019155] LTTng-UST debug: &lt;module&gt;(): debug is enabled<br>
[0.024447] LTTng-UST debug: _init_threads(): entering<br>
[0.024710] LTTng-UST debug: _get_port_from_file(): reading port from file &=
quot;/var/run/lttng/agent.port&quot;<br>
[0.025745] LTTng-UST debug: _get_port_from_file(): reading port from file &=
quot;/root/.lttng/agent.port&quot;<br>
[0.025942] LTTng-UST debug: _init_threads(): system session daemon port: 53=
45<br>
[0.026117] LTTng-UST debug: _init_threads(): user session daemon port: None=
<br>
[0.026280] LTTng-UST debug: _init_threads(): creating system client thread<=
br>
[0.026762] LTTng-UST debug: _init_threads(): created and started system cli=
ent thread<br>
[0.026973] LTTng-UST debug: _init_threads(): waiting for registration done =
(expecting 1, timeout is 5.0 s)<br>
[0.027721] LTTng-UST debug: _client_thread_target(): creating client &quot;=
system&quot; using TCP port 5345<br>
[0.029745] LTTng-UST debug: _client_thread_target(): starting client &quot;=
system&quot;<br>
[0.029896] LTTng-UST debug: run(): client &quot;system&quot;: connecting to=
 session daemon<br>
[0.030117] LTTng-UST debug: run(): client &quot;system&quot;: registering t=
o session daemon<br>
[0.030370] LTTng-UST debug: _recv_server_cmd_header(): client &quot;system&=
quot;: received empty server command header<br>
[0.030532] LTTng-UST debug: _handle_server_cmd(): client &quot;system&quot;=
: bad server command<br>
[0.030667] LTTng-UST debug: run(): client &quot;system&quot;: got exception=
: &#39;module&#39; object has no attribute &#39;_ClientCmdReply&#39;<br>
####<br>
You can see &#39;bad server command&#39; and &#39;exception&#39; in the las=
t lines.<br>
<br>
J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficio=
s.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt; a =C3=A9cri=
t :<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
2015-11-06 17:59 GMT-05:00 Yves Junior Bationo &lt;<a href=3D"mailto:yves-j=
unior.bationo@polymtl.ca" target=3D"_blank">yves-junior.bationo@polymtl.ca<=
/a>&gt;:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
j&#39;ai un souci avec lltngust pour les application python<br>
Pour l&#39;exemple de la Doc<br>
=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lttng.org/docs/#doc-python-applicat=
ion" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/#doc-pytho=
n-application</a><br>
j&#39;ai l&#39;erreur:<br>
=C2=A0 =C2=A0 =C2=A0 No handlers could be found for logger &quot;hello-logg=
er&quot;<br>
<br>
</blockquote>
<br>
Hi Yves,<br>
<br>
We try to stick to English on this mailing list so the questions and<br>
answers remain easily searchable.<br>
<br>
The example in the docs uses &quot;time&quot; without importing it, I have =
sent<br>
a Pull Request to address that.<br>
However, addressing the problem you are encountering, where does<br>
&quot;hello-logger&quot; come from?<br>
<br>
Can you post the code and versions of the components you are using?<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
la commande &quot;lttng list -u -a&quot; me retourne bien la liste des trac=
e point:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 PID: 5228 - Name: python<br>
=C2=A0 =C2=A0 lttng_python:event (loglevel: TRACE_DEBUG_LINE (13)) (type:<b=
r>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (=
type:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LI=
NE (13))<br>
(type: tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (loglevel:<br>
TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEBUG_UN=
IT (11))<br>
(type: tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglevel: TRACE_DEBUG_=
MODULE<br>
(10)) (type: tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_DEBUG_PROCESS (loglevel: TRACE_DEBUG=
_PROCESS<br>
(9)) (type: tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel: TRACE_DEBUG=
_PROGRAM<br>
(8)) (type: tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel: TRACE_DEBUG_=
SYSTEM<br>
(7)) (type: tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_INFO (loglevel: TRACE_INFO (6)) (typ=
e:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_NOTICE (loglevel: TRACE_NOTICE (5)) =
(type:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_WARNING (loglevel: TRACE_WARNING (4)=
) (type:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (type:=
<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_CRIT (loglevel: TRACE_CRIT (2)) (typ=
e:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_ALERT (loglevel: TRACE_ALERT (1)) (t=
ype:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracelog:TRACE_EMERG (loglevel: TRACE_EMERG (0)) (t=
ype:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 lttng_ust_statedump:end (loglevel: TRACE_DEBUG_LINE (13)) (ty=
pe:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_statedump:debug_link (loglevel: TRACE_DEBUG_LINE (1=
3))<br>
(type: tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_statedump:build_id (loglevel: TRACE_DEBUG_LINE (13)=
) (type:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13)) =
(type:<br>
tracepoint)<br>
=C2=A0 =C2=A0 lttng_ust_statedump:start (loglevel: TRACE_DEBUG_LINE (13)) (=
type:<br>
tracepoint)<br>
<br>
Mais pas de resultats dans le repertoire des evenements lorsque j&#39;activ=
e le<br>
tracage lttng.<br>
<br>
Resum=C3=A9<br>
=C2=A0 =C2=A0 =C2=A0 Probleme 1 :No handlers could be found for logger<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 je croyais que &quot;impor=
t lttngust&quot; devait gerer cette<br>
situation<br>
<br>
=C2=A0 =C2=A0 =C2=A0 Probleme 2: pas de resultats au tracage<br>
Merci.<br>
<br>
<br>
<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</blockquote>
<br>
<br>
<br>
-- <br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</blockquote></blockquote>
<br>
<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</blockquote>
<br>
-- <br>
Jonathan R. Julien<br>
Efficios<br>
</blockquote>
<br>
<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Jonat=
han Rajotte Julien<div><br></div></div></div></div></div>
</div>

--001a113eea42a2ff6c05246e7378--


--===============0114029937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0114029937==--
