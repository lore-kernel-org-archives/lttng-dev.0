From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: Regarding lttng enable-event using filter option
Date: Tue, 10 Mar 2015 11:53:17 +0000
Message-ID: <20150310115317.Horde.7cvQTfxFiSqai0TJwZ3JPA1__17859.9883839071$1425988450$gmane$org@www.imp.polymtl.ca>
References: <OF2679224C.7D5F648E-ON65257E04.001D6D14-65257E04.001E1BBD@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <suchakrapani.sharma@polymtl.ca>) id 1YVIiq-00054u-0q
 for lttng-dev@lists.lttng.org; Tue, 10 Mar 2015 07:53:18 -0400
In-Reply-To: <OF2679224C.7D5F648E-ON65257E04.001D6D14-65257E04.001E1BBD@tcs.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, venkata.kantimahanthi@tcs.com
List-Id: lttng-dev@lists.lttng.org

Hi,

> o/p
> Event com_ericsson_tri*: Filter 'strfield == "TRACE_UTS"' successfully set
>
> So , If I have enabled above event with filter , the traces which have
> string field with TRACE_UTS as data should not be logged. This is as per
> my understanding. Is is correct ?

No, its not correct. There is no field with the name "strfield" in  
your trace playload.

For example, if this is what your tracepoint records in a usual case,

[07:45:08.810173787] (+0.000017406) isengard retlif_tp:tpfilt: {  
cpu_id = 1 }, { var0 = "str0", var1 = "str1", var2 = "str2", var3 =  
"str3", var4 = "str4", var5 = "str5", var6 = "str6", var7 = "str7",  
var8 = "str8", lyf = 42 }

Then you can set a filter like this,

lttng enable-event -u retlif_tp:tpfilt --filter '(var0 == "str0") &&  
(var1 == "Jon") && (var2 == "Doe") && (lyf == 42)'

This works for me.

--
Suchakra
