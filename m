From: Danny Serres <serres@live.ca>
Subject: Re: babletrace with python bindings
Date: Wed, 19 Dec 2012 17:30:03 -0500
Message-ID: <BLU0-SMTP2818942FC1D7AF2777A5F2C0300__30951.8696777106$1355956258$gmane$org@phx.gbl>
References: <20121218184045.288000@gmx.com> <20121219183932.GA9587@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu0-omc3-s22.blu0.hotmail.com ([65.55.116.97])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <serres@live.ca>) id 1TlS9V-0000LL-5Q
	for lttng-dev@lists.lttng.org; Wed, 19 Dec 2012 17:30:13 -0500
In-Reply-To: <20121219183932.GA9587@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, ajonwa ajonwa <ajonwa@gmx.com>
List-Id: lttng-dev@lists.lttng.org

On 12-12-19 01:39 PM, Mathieu Desnoyers wrote:
> * ajonwa ajonwa (ajonwa@gmx.com) wrote:
>> Hello everyone,
>>
>>   I get the following error message while attempting to compile babeltrace with python bindings:
>>
>>   CC _babeltrace_la-babeltrace_wrap.lo
>> babeltrace_wrap.c: In function '_wrap__bt_ctf_field_type':
>> babeltrace_wrap.c:4621:56: warning: passing argument 1 of 'bt_ctf_field_type' from incompatible pointer type [enabled by default]
>> ../../include/babeltrace/ctf/events.h:158:18: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
>> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_signedness':
>> babeltrace_wrap.c:4643:51: warning: passing argument 1 of 'bt_ctf_get_int_signedness' from incompatible pointer type [enabled by default]
>> ../../include/babeltrace/ctf/events.h:167:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
>> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_base':
>> babeltrace_wrap.c:4665:45: warning: passing argument 1 of 'bt_ctf_get_int_base' from incompatible pointer type [enabled by default]
>> ../../include/babeltrace/ctf/events.h:172:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
>> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_byte_order':
>> babeltrace_wrap.c:4687:51: warning: passing argument 1 of 'bt_ctf_get_int_byte_order' from incompatible pointer type [enabled by default]
>> ../../include/babeltrace/ctf/events.h:178:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
>> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_len':
>> babeltrace_wrap.c:4709:39: warning: passing argument 1 of 'bt_ctf_get_int_len' from incompatible pointer type [enabled by default]
>> ../../include/babeltrace/ctf/events.h:184:9: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
>> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_encoding':
>> babeltrace_wrap.c:4731:66: warning: passing argument 1 of 'bt_ctf_get_encoding' from incompatible pointer type [enabled by default]
>> ../../include/babeltrace/ctf/events.h:190:26: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
>> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_array_len':
>> babeltrace_wrap.c:4753:46: warning: passing argument 1 of 'bt_ctf_get_array_len' from incompatible pointer type [enabled by default]
>> ../../include/babeltrace/ctf/events.h:196:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
>> babeltrace_wrap.c: In function 'init_babeltrace':
>> babeltrace_wrap.c:6020:61: error: 'BT_SEEK_END' undeclared (first use in this function)
>> babeltrace_wrap.c:6020:61: note: each undeclared identifier is reported only once for each function it appears in
>> make[3]: *** [_babeltrace_la-babeltrace_wrap.lo] Error 1
>>
>>   I got the source code by checking out bindings/python (git checkout bindings/python).
>>
>>   I will be grateful if someone would tell how to fix the error.
Babeltrace API changed since this was made.  To fix it, simply edit the 
appropriate lines of the
  lttng.i.in swig file in extras/bindings/swig/python (see the 
CTF/EVENTS.H section of the file) and make sure all function 
declarations match the ones in include/ctf/events.h
 From the error message, most (if not all) *const struct definition* 
args must be changed to
*const struct declaration*
This might yield some errors in the Python code itself regarding 
Definition objects.
That class would need to be rewritten to fit the new API, along with the 
corresponding functions.
But it should compile anyway
Also the 3 BT_SEEK_END lines must be changed to BT_SEEK_LAST

Hope this helps
Danny

> This branch is currently in development, and might be out of sync with
> the master branch of babeltrace at the moment. We don't have immediate
> plans to work on it, but bontributions are welcome.
>
> Thanks,
>
> Mathieu
>
>>
>> B
>>   Thanks,
>>
>>   Geoffreyget_int_s
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
