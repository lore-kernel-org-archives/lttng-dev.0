From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Teach babeltrace understand "native"
	and	"network" for byte_order
Date: Fri, 15 Mar 2013 11:33:20 -0400
Message-ID: <20130315153320.GA1659__49357.2465064519$1363361648$gmane$org@Krystal>
References: <1363341137-26956-1-git-send-email-yao@codesourcery.com>
	<20130315120753.GA30973@Krystal> <20130315143337.GA959@Krystal>
	<51433B38.3080805@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UGWdF-00026D-BE
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 11:33:21 -0400
Content-Disposition: inline
In-Reply-To: <51433B38.3080805@codesourcery.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yao Qi <yao@codesourcery.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Yao Qi (yao@codesourcery.com) wrote:
> On 03/15/2013 10:33 PM, Mathieu Desnoyers wrote:
>>     byte_order = native OR network OR be OR le;	/* network and be are aliases */
>>
>> +Even though the trace description section is not per se a type, for sake
>> +of clarity, it should be noted that native and network byte orders are
>> +only allowed within type declaration. The byte_order specified in the
>> +trace description section only accepts be OR le values.
>> +
>
> The first and last sentence below is a little bit confusing to me.
>
> 4.1.3 Byte order
>
> By default, the native endianness of the source architecture is used.
> ....
> If not specified, the byte order is native.
>
>
> 1.  "native endianness" appear in the spec for the first time, without a  
> precise explanation.  After your explanation in the last mail, I got to  
> know it is the endianess described in the trace description.
>
> 2.  "source architecture" is not clear to me.
>
> Maybe, we can say something like:
>
> "By default, byte order of a basic type is the byte order described in  
> the trace description.  It can be overridden by specifying a  
> "byte_order" attribute for a basic type.  Typical use-case is to specify  
> the network byte order (big endian: "be") to save data captured from the  
> network into the trace without conversion."
>
> I also suggest that we get rid of the term "native" here.  IIUC, we have  
> four options for byte order, default, network, le and be.  The latter  
> three are easy to understand, and if attribute "byte_order" is not  
> specified, it is the default.  On the other hand, "native endianness"  
> means the endianness of underlying machine, which is a little different.

I added an explanatory paragraph for "native" in addition to your
recommended changes. We cannot remove an keyword from the specification
lightly, because this would break compatibility.

>
> I am not good at documentation, nor a native English speaker.  My  
> suggestion can be wrong.

Here is the update. Comments are welcome!

Thanks,

Mathieu

commit 237324a20398c5c8eaf92aff0eace177ef8a747f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Mar 15 11:32:03 2013 -0400

    Clarify byte order section
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/common-trace-format-specification.txt b/common-trace-format-specification.txt
index 4ab3ed9..797dec1 100644
--- a/common-trace-format-specification.txt
+++ b/common-trace-format-specification.txt
@@ -171,20 +171,23 @@ TSDL meta-data attribute representation of a specific alignment:
 
 4.1.3 Byte order
 
-By default, the native endianness of the source architecture is used.
-Byte order can be overridden for a basic type by specifying a "byte_order"
-attribute. Typical use-case is to specify the network byte order (big endian:
-"be") to save data captured from the network into the trace without conversion.
-If not specified, the byte order is native.
+By default, byte order of a basic type is the byte order described in
+the trace description.  It can be overridden by specifying a
+"byte_order" attribute for a basic type.  Typical use-case is to specify
+the network byte order (big endian: "be") to save data captured from the
+network into the trace without conversion.
 
 TSDL meta-data representation:
 
   byte_order = native OR network OR be OR le;	/* network and be are aliases */
 
+The "native" keyword selects the byte order described in the trace
+description. The "network" byte order is an alias for big endian.
+
 Even though the trace description section is not per se a type, for sake
-of clarity, it should be noted that native and network byte orders are
-only allowed within type declaration. The byte_order specified in the
-trace description section only accepts be OR le values.
+of clarity, it should be noted that "native" and "network" byte orders
+are only allowed within type declaration. The byte_order specified in
+the trace description section only accepts "be" or "le" values.
 
 4.1.4 Size
 


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
