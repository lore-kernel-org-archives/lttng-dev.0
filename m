Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560DEC433F5
	for <lttng-dev@archiver.kernel.org>; Tue, 26 Apr 2022 06:38:18 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KnXJS3KndzDXS;
	Tue, 26 Apr 2022 02:38:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1650955097;
	bh=99C4QTpf4CfbZBQY8jrwXRDBl1hRB4snn/tWx+2mYLg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Raje4kthozVjdy7JNqfdCli4OUZqgr337qCT3jbJ5HTJDLay6PiWLoh3WI05paBsd
	 upJDIgwQkmPO9Y39Qpa3biBymN3Z3UgKpjTghb+s0oxfQaltO8OJfIx6Cdz4cPmOvb
	 23O9jgor0sNm9tH20YOgA60F82fnxDa4hkBPCn2+7LmT4sUJcctM2BZUm+h6SepF0R
	 6gvsE+k4QgytLY/yzx0L0hNSNrUGBbvCZegVjfyZsW0g9vwipFw3TamMgeP+tS5qvM
	 xVu4/dqVXZ1Mj3d3A7Aij9jQpVZG09mBG+LAgW4jvwTmv6LXwEiL8Euzwn+m5b3Gyo
	 qh79LslmZy1HQ==
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KnXJQ6dhBz1D4f
 for <lttng-dev@lists.lttng.org>; Tue, 26 Apr 2022 02:38:13 -0400 (EDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-S-gNuP66PQ-tp2XSQqFnig-1; Tue, 26 Apr 2022 02:36:55 -0400
X-MC-Unique: S-gNuP66PQ-tp2XSQqFnig-1
Received: by mail-wr1-f71.google.com with SMTP id
 t15-20020adfdc0f000000b001ef93643476so4056770wri.2
 for <lttng-dev@lists.lttng.org>; Mon, 25 Apr 2022 23:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9i0LRPyNEJc6bvUmFcC0BsQd2Cd/7OUqQ7P+EjHdKXY=;
 b=SbJDptXrrYZYVNPrgbmd0bWsOyYtZpIvpAIU9f8yjCBVi6R41M30palJSRUl36PFGP
 PGcidQ4/vSlQifLxivwwf1YI6dD6CjH921U470r6XOOOYlQea0iQrRbm460W6IFWGpk7
 h74arot/PTBqPeYSGGpnL63yVq/TbykqqiZW+yyb/a9iU4PIv3OGAfTEikuuM6Y6tUtx
 OPNBwo+ShIM6AbrIfor25mcDMCc2SVJY4SaBybFiAP6hGHKRBfHrDesUdle23MVnKDUv
 KyQWbxrb0mk9OxunhekqTeZ56VMHTIqvb5BxPorJWFvXtw43yPJCj0lSdRXa910pDzJU
 01Cg==
X-Gm-Message-State: AOAM530UpUm/iCWaKjoNTuqqN881ZNZsQG96M7lD5Fw2E8LS/3QZWaIc
 XZavs7cNqe0QZvOKaFlP705x5fGqnywSdK5naRA1rBM0b50qEll8GTzoFQCpXN43ExaQxZFYb9J
 ohYpeSRzFmc4tMIfDRHkC
X-Received: by 2002:a05:600c:410c:b0:38e:d2b5:ef2a with SMTP id
 j12-20020a05600c410c00b0038ed2b5ef2amr19376758wmi.91.1650955014159; 
 Mon, 25 Apr 2022 23:36:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5bs431vMW7b0fsHaky/7iiODeCAXOCFJOhJPStoFps+KoTnjB2J/kUa3Bzs0oKUjj6aDEBg==
X-Received: by 2002:a05:600c:410c:b0:38e:d2b5:ef2a with SMTP id
 j12-20020a05600c410c00b0038ed2b5ef2amr19376748wmi.91.1650955013955; 
 Mon, 25 Apr 2022 23:36:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.googlemail.com with ESMTPSA id
 f4-20020a7bc8c4000000b0038ebbe10c5esm12942575wml.25.2022.04.25.23.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 23:36:53 -0700 (PDT)
Message-ID: <18ffeaf2-cb4c-ad6f-51eb-a4cdd5cd3c31@redhat.com>
Date: Tue, 26 Apr 2022 08:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <1218866473.10909.1649432186473.JavaMail.zimbra@efficios.com>
 <3c11308e-006a-a7e9-8482-c6b341690530@redhat.com>
 <1622857974.11247.1649441213797.JavaMail.zimbra@efficios.com>
 <20220425100434.2f5d18bb@gandalf.local.home>
 <892959086.34940.1650902572304.JavaMail.zimbra@efficios.com>
In-Reply-To: <892959086.34940.1650902572304.JavaMail.zimbra@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Subject: Re: [lttng-dev] Unexport of kvm_x86_ops vs tracer modules
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Paolo Bonzini via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
 lttng-dev <lttng-dev@lists.lttng.org>, KVM list <kvm@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 4/25/22 18:02, Mathieu Desnoyers wrote:
>> Now another solution is to make the fast assigns available to anyone, and
>> to allow you to simply pass in a pointer and size to have the data written
>> into it. That is, you get the results of the TRACE_EVENT and not have to
>> depend on internal data from the tracepoint.
> If the fast assign can then be used on a field-per-field basis, maybe this
> could work, but AFAIK the fast-assign macro is open-coded C, which makes this
> not straightforward.
> 
> If it's a all-or-nothing approach where the fast-assign needs to serialize all
> fields, this would require that lttng copies the data into a temporary area,
> which is something I want to avoid for filtering and event notification per-field
> payload capture purposes.

It wouldn't be great; but it wouldn't be any worse than doing any 
complex calculations inside an "if (trace_xyz_enabled())", and passing 
them as arguments to the tracepoint function, which is what you 
suggested earlier.

Paolo

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
