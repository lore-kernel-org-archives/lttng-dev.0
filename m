From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Java Agent JAR file symlink
 should be created after objects install
Date: Tue, 4 Nov 2014 16:26:13 -0500
Message-ID: <CAGDH53kbntDrpKPwHc=3d3xXfurTdvzXaOBLP0hx9X4k6rHUPA__41671.7576598332$1415136429$gmane$org@mail.gmail.com>
References: <1415133647-18866-1-git-send-email-christian.babeux@efficios.com>
 <628235827.7568.1415135194527.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XllcJ-0000Ss-Rw
 for lttng-dev@lists.lttng.org; Tue, 04 Nov 2014 16:26:26 -0500
Received: by mail-wi0-f181.google.com with SMTP id n3so267536wiv.14
 for <lttng-dev@lists.lttng.org>; Tue, 04 Nov 2014 13:26:13 -0800 (PST)
In-Reply-To: <628235827.7568.1415135194527.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

> Why are there sometimes "&&" and sometimes ";" between the shell
> commands ? I think we might want to have && everywhere, so the
> following commands don't execute if the prior commands fail.

The reasoning was to ensure that if the "rm" command returned a
non-zero exit code when removing non-existent files, it would still
proceed to create the symlink.
It seems that "rm -f" will never return a non-zero exit code when
removing non-existent file, so I will resubmit this patch with the
appropriate &&.

Thanks,

Christian

On Tue, Nov 4, 2014 at 4:06 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Hi Christian,
>
> Why are there sometimes "&&" and sometimes ";" between the shell
> commands ? I think we might want to have && everywhere, so the
> following commands don't execute if the prior commands fail.
>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
> ----- Original Message -----
>> From: "Christian Babeux" <christian.babeux@efficios.com>
>> To: lttng-dev@lists.lttng.org
>> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "Christian Babeux" <christian.babeux@efficios.com>
>> Sent: Tuesday, November 4, 2014 3:40:47 PM
>> Subject: [PATCH lttng-ust] Fix: Java Agent JAR file symlink should be created after objects install
>>
>> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
>> ---
>>  liblttng-ust-java-agent/java/Makefile.am | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/liblttng-ust-java-agent/java/Makefile.am
>> b/liblttng-ust-java-agent/java/Makefile.am
>> index 5a406e4..42b3ede 100644
>> --- a/liblttng-ust-java-agent/java/Makefile.am
>> +++ b/liblttng-ust-java-agent/java/Makefile.am
>> @@ -46,7 +46,7 @@ classes += $(pkgpath)/log4j/*.class
>>  endif
>>
>>  $(jarfile): classnoinst.stamp
>> -     $(JAR) cfm $(JARFLAGS) $@ $(jarfile_manifest) $(classes) && $(LN_S) $@
>> $(jarfile_symlink)
>> +     $(JAR) cfm $(JARFLAGS) $@ $(jarfile_manifest) $(classes) && rm -f
>> $(jarfile_symlink); $(LN_S) $@ $(jarfile_symlink)
>>
>>  $(jarfile_old): classnoinst.stamp
>>       $(JAR) cf $(JARFLAGS) $@ $(pkgpath)/*.class \
>> @@ -62,10 +62,10 @@ log4j-jni-header.stamp: $(dist_noinst_JAVA)
>>
>>  all-local: $(stamp)
>>
>> -install-data-local:
>> +install-data-hook:
>>       cd $(DESTDIR)/$(jardir); rm -f $(jarfile_symlink); $(LN_S) $(jarfile)
>>       $(jarfile_symlink)
>>
>> -uninstall-local:
>> +uninstall-hook:
>>       cd $(DESTDIR)/$(jardir); rm -f $(jarfile_symlink)
>>
>>  CLEANFILES = $(jarfile) $(jarfile_old) $(pkgpath)/*.class
>>  $(pkgpath_old)/*.class $(pkgpath)/jul/*.class \
>> --
>> 2.1.1
>>
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
