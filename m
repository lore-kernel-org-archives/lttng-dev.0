From: Julien Desfossez <julien.desfossez@polymtl.ca>
Subject: Re: [PATCH babeltrace] Fix: Double free
	in	bt_context_remove_trace().
Date: Mon, 21 Jan 2013 17:04:41 -0500
Message-ID: <50FDBB79.5050908__13515.8322439112$1358805933$gmane$org@polymtl.ca>
References: <1358777874-24083-1-git-send-email-jeremie.galarneau@efficios.com>
	<20130121193225.GA8005@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <julien.desfossez@polymtl.ca>) id 1TxPU1-0006S4-Hv
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 17:04:49 -0500
In-Reply-To: <20130121193225.GA8005@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 21/01/13 02:32 PM, Mathieu Desnoyers wrote:
> * J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
>> ctf_close_trace was being called twice when calling bt_context_remove_tr=
ace thus
>> causing free() to be called on an invalid pointer.
>>
>> Calling bt_context_remove_trace() would call ctf_close_trace() once via =
the
>> close_handle callback registered on the ctf format struct and a second c=
all would
>> take place from bt_trace_handle_destroy() which is registered as the
>> value_destroy_func on the trace_handles hash table of the current contex=
t.
>>
>> The first explicit call to handle->format->close_trace is unnecessary.
>>
>> The crash is reproducible by invoking the tests-python.py script.
> =

> I think we should leave the close_trace calls in both locations, but set
> handle->td to -1 when we close it, and test for negative handle ID
> before doing the close.

I agree, we need the two calls to close, one is called when we remove a
trace manually and the other one is called when we destroy the context.
Setting and testing the td to -1 will solve the problem and will avoid
calling close_trace at all if not needed.

Thanks,

Julien

> =

> Thanks,
> =

> Mathieu
> =

>>
>> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
>> ---
>>  lib/context.c      | 8 +-------
>>  lib/trace-handle.c | 5 ++++-
>>  2 files changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/context.c b/lib/context.c
>> index 5516e49..05fb994 100644
>> --- a/lib/context.c
>> +++ b/lib/context.c
>> @@ -156,7 +156,6 @@ end:
>>  int bt_context_remove_trace(struct bt_context *ctx, int handle_id)
>>  {
>>  	struct bt_trace_handle *handle;
>> -	int ret;
>>  =

>>  	if (!ctx)
>>  		return -EINVAL;
>> @@ -168,12 +167,7 @@ int bt_context_remove_trace(struct bt_context *ctx,=
 int handle_id)
>>  =

>>  	/* Remove from containers */
>>  	trace_collection_remove(ctx->tc, handle->td);
>> -	/* Close the trace */
>> -	ret =3D handle->format->close_trace(handle->td);
>> -	if (ret) {
>> -		fprintf(stderr, "Error in close_trace callback\n");
>> -		return ret;
>> -	}
>> +
>>  	/* Remove and free the handle */
>>  	g_hash_table_remove(ctx->trace_handles,
>>  			(gpointer) (unsigned long) handle_id);
>> diff --git a/lib/trace-handle.c b/lib/trace-handle.c
>> index 0da565b..17a6e0d 100644
>> --- a/lib/trace-handle.c
>> +++ b/lib/trace-handle.c
>> @@ -49,7 +49,10 @@ struct bt_trace_handle *bt_trace_handle_create(struct=
 bt_context *ctx)
>>  =

>>  void bt_trace_handle_destroy(struct bt_trace_handle *th)
>>  {
>> -	th->format->close_trace(th->td);
>> +	if (th->format->close_trace(th->td)) {
>> +		fprintf(stderr, "Error in close_trace callback\n");
>> +	}
>> +
>>  	g_free(th);
>>  }
>>  =

>> -- =

>> 1.8.1.1
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
