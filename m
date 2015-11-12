From: Yves Junior Bationo <yves-junior.bationo@polymtl.ca>
Subject: Re: Help-lttng-ust-pyhton
Date: Thu, 12 Nov 2015 16:43:32 +0000
Message-ID: <20151112164332.Horde.29NGfz3UJ4wgzaNFRJRqxf-__47793.9983750277$1447351831$gmane$org@www.imp.polymtl.ca>
References: <20151106225909.Horde.ZKUBbt2vnWaMa-0QDzy6txy@www.imp.polymtl.ca>
 <CA+jJMxvgz2D=ga+7fC4FTdnJ0obQLz1K38G7sUrnuqhCMKXg7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_dwB6V-bWqYsYJ17OkE7w67_"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <yves-junior.bationo@polymtl.ca>) id 1Zwuy3-0004YS-CP
 for lttng-dev@lists.lttng.org; Thu, 12 Nov 2015 11:43:27 -0500
In-Reply-To: <CA+jJMxvgz2D=ga+7fC4FTdnJ0obQLz1K38G7sUrnuqhCMKXg7g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?b?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, Philippe Proulx <philippe.proulx@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This message is in MIME format.

--=_dwB6V-bWqYsYJ17OkE7w67_
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id tACI7Tkc004566

Hi, i my script i just change "my-logger" by "hello-logger" (hello.py =20
in attachment).
I try to figure out the probem by
		export LTTNG_UST_PYTHON_DEBUG=3D1
and i found this:
#####
[0.019155] LTTng-UST debug: <module>(): debug is enabled
[0.024447] LTTng-UST debug: _init_threads(): entering
[0.024710] LTTng-UST debug: _get_port_from_file(): reading port from =20
file "/var/run/lttng/agent.port"
[0.025745] LTTng-UST debug: _get_port_from_file(): reading port from =20
file "/root/.lttng/agent.port"
[0.025942] LTTng-UST debug: _init_threads(): system session daemon port: =
5345
[0.026117] LTTng-UST debug: _init_threads(): user session daemon port: No=
ne
[0.026280] LTTng-UST debug: _init_threads(): creating system client threa=
d
[0.026762] LTTng-UST debug: _init_threads(): created and started =20
system client thread
[0.026973] LTTng-UST debug: _init_threads(): waiting for registration =20
done (expecting 1, timeout is 5.0 s)
[0.027721] LTTng-UST debug: _client_thread_target(): creating client =20
"system" using TCP port 5345
[0.029745] LTTng-UST debug: _client_thread_target(): starting client "sys=
tem"
[0.029896] LTTng-UST debug: run(): client "system": connecting to =20
session daemon
[0.030117] LTTng-UST debug: run(): client "system": registering to =20
session daemon
[0.030370] LTTng-UST debug: _recv_server_cmd_header(): client =20
"system": received empty server command header
[0.030532] LTTng-UST debug: _handle_server_cmd(): client "system": bad =20
server command
[0.030667] LTTng-UST debug: run(): client "system": got exception: =20
'module' object has no attribute '_ClientCmdReply'
####
You can see 'bad server command' and 'exception' in the last lines.

J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> a =C3=A9crit=
=C2=A0:

> 2015-11-06 17:59 GMT-05:00 Yves Junior Bationo =20
> <yves-junior.bationo@polymtl.ca>:
>>
>> j'ai un souci avec lltngust pour les application python
>> Pour l'exemple de la Doc
>>         https://lttng.org/docs/#doc-python-application
>> j'ai l'erreur:
>>         No handlers could be found for logger "hello-logger"
>>
>
> Hi Yves,
>
> We try to stick to English on this mailing list so the questions and
> answers remain easily searchable.
>
> The example in the docs uses "time" without importing it, I have sent
> a Pull Request to address that.
> However, addressing the problem you are encountering, where does
> "hello-logger" come from?
>
> Can you post the code and versions of the components you are using?
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
>
>> la commande "lttng list -u -a" me retourne bien la liste des trace poi=
nt:
>>
>>         PID: 5228 - Name: python
>>       lttng_python:event (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)
>>       lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (typ=
e:
>> tracepoint)
>>       lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE =
(13))
>> (type: tracepoint)
>>       lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (loglevel:
>> TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
>>       lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEBUG_UNIT =
(11))
>> (type: tracepoint)
>>       lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglevel: TRACE_DEBUG_MOD=
ULE
>> (10)) (type: tracepoint)
>>       lttng_ust_tracelog:TRACE_DEBUG_PROCESS (loglevel: TRACE_DEBUG_PR=
OCESS
>> (9)) (type: tracepoint)
>>       lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel: TRACE_DEBUG_PR=
OGRAM
>> (8)) (type: tracepoint)
>>       lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel: TRACE_DEBUG_SYS=
TEM
>> (7)) (type: tracepoint)
>>       lttng_ust_tracelog:TRACE_INFO (loglevel: TRACE_INFO (6)) (type:
>> tracepoint)
>>       lttng_ust_tracelog:TRACE_NOTICE (loglevel: TRACE_NOTICE (5)) (ty=
pe:
>> tracepoint)
>>       lttng_ust_tracelog:TRACE_WARNING (loglevel: TRACE_WARNING (4)) (=
type:
>> tracepoint)
>>       lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (type:
>> tracepoint)
>>       lttng_ust_tracelog:TRACE_CRIT (loglevel: TRACE_CRIT (2)) (type:
>> tracepoint)
>>       lttng_ust_tracelog:TRACE_ALERT (loglevel: TRACE_ALERT (1)) (type=
:
>> tracepoint)
>>       lttng_ust_tracelog:TRACE_EMERG (loglevel: TRACE_EMERG (0)) (type=
:
>> tracepoint)
>>       lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type: trace=
point)
>>       lttng_ust_statedump:end (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)
>>       lttng_ust_statedump:debug_link (loglevel: TRACE_DEBUG_LINE (13))
>> (type: tracepoint)
>>       lttng_ust_statedump:build_id (loglevel: TRACE_DEBUG_LINE (13)) (=
type:
>> tracepoint)
>>       lttng_ust_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13)) (ty=
pe:
>> tracepoint)
>>       lttng_ust_statedump:start (loglevel: TRACE_DEBUG_LINE (13)) (typ=
e:
>> tracepoint)
>>
>> Mais pas de resultats dans le repertoire des evenements lorsque j'acti=
ve le
>> tracage lttng.
>>
>> Resum=C3=A9
>>         Probleme 1 :No handlers could be found for logger
>>                 je croyais que "import lttngust" devait gerer cette
>> situation
>>
>>         Probleme 2: pas de resultats au tracage
>> Merci.
>>
>>
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com


--=_dwB6V-bWqYsYJ17OkE7w67_
Content-Type: text/x-java; name=hello.py
Content-Disposition: attachment; size=378; filename=hello.py

import lttngust
import logging
import time

def example():
    logger = logging.getLogger('hello-logger')

    while True:
        logger.debug('debug message')
        logger.info('info message')
        logger.warn('warn message')
        logger.error('error message')
        logger.critical('critical message')
        time.sleep(1)

if __name__ == '__main__':
    example()
--=_dwB6V-bWqYsYJ17OkE7w67_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=_dwB6V-bWqYsYJ17OkE7w67_--
