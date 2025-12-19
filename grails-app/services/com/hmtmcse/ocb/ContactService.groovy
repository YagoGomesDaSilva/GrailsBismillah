package com.hmtmcse.ocb

import grails.web.servlet.mvc.GrailsParameterMap
import jakarta.servlet.http.HttpServletRequest
import grails.gorm.transactions.Transactional

@Transactional
class ContactService {

    AuthenticationService authenticationService
    ContactDetailsService contactDetailsService

    def save(GrailsParameterMap params, HttpServletRequest request) {
        def sessionMember = authenticationService.getMember()
        if (!sessionMember) {
            return AppUtil.saveResponse(false, null)
        }

        Member currentMember = Member.get(sessionMember.id)
        if (!currentMember) {
            return AppUtil.saveResponse(false, null)
        }
        
        Contact contact = new Contact()
        contact.name = params.name
        contact.member = currentMember
        
        // Handle contactGroup if provided
        if (params.contactGroup) {
            def groupIds = params.list('contactGroup')
            groupIds.each { groupId ->
                def group = ContactGroup.get(groupId)
                if (group) {
                    contact.addToContactGroup(group)
                }
            }
        }
        
        def response = AppUtil.saveResponse(false, contact)
        if (contact.validate()) {
            contact.save(flush: true, failOnError: true)
            if (!contact.hasErrors()){
                response.isSuccess = true
                contactDetailsService.createOrUpdateDetails(contact, params)
                uploadImage(contact, request)
            }
        } else {
            println("ERRO de validação: ${contact.errors}")
        }
        return response
    }

    def update(Contact contact, GrailsParameterMap params, HttpServletRequest request) {
        contact.properties = params
        def response = AppUtil.saveResponse(false, contact)
        if (contact.validate()) {
            contact.save(flush: true)
            if (!contact.hasErrors()){
                response.isSuccess = true
                contactDetailsService.createOrUpdateDetails(contact, params)
                uploadImage(contact, request)
            }
        }
        return response
    }


    def get(Serializable id) {
        return Contact.get(id)
    }


    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        def sessionMember = authenticationService.getMember()
        Member currentMember = Member.get(sessionMember.id)
        List<Contact> contactList = Contact.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                like(params.colName, "%" + params.colValue + "%")
            }
            if (!params.sort) {
                order("id", "desc")
            }
            eq("member", currentMember)
        }
        return [list: contactList, count: contactList.totalCount]
    }


    def delete(Contact contact) {
        try {
            contact.delete(flush: true)
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }

    def uploadImage(Contact contact, HttpServletRequest request){
        if (request.getFile("contactImage") && !request.getFile("contactImage").filename.equals("")){
            String image = FileUtil.uploadContactImage(contact.id, request.getFile("contactImage"))
            if (!image.equals("")){
                contact.image = image
                contact.save(flush:true)
            }
        }
    }

}