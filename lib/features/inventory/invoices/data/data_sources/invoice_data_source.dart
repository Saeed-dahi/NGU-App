import 'dart:convert';

import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';

import 'package:ngu_app/features/inventory/invoices/data/models/invoice_model.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/params/invoice_items_model_params.dart';

abstract class InvoiceDataSource {
  Future<List<InvoiceModel>> getAllInvoices(String type);
  Future<InvoiceModel> showInvoice(
      int invoiceId, String? direction, String type);
  Future<InvoiceModel> createInvoice(
      InvoiceModel invoiceModel, List<InvoiceItemsModelParams> items);
  Future<InvoiceModel> updateInvoice(
      InvoiceModel invoiceModel, List<InvoiceItemsModelParams> items);

  Future<InvoiceModel> getCreateInvoiceFormData(String type);
}

class InvoiceDataSourceImpl implements InvoiceDataSource {
  final NetworkConnection networkConnection;

  InvoiceDataSourceImpl({required this.networkConnection});

  @override
  Future<List<InvoiceModel>> getAllInvoices(String type) async {
    final response =
        await networkConnection.get(APIList.invoice, {'type': type});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<InvoiceModel> invoices = decodedJson['data']
        .map<InvoiceModel>((invoice) => InvoiceModel.fromJson(invoice))
        .toList();

    return invoices;
  }

  @override
  Future<InvoiceModel> showInvoice(
      int invoiceId, String? direction, String type) async {
    final response =
        await networkConnection.get('${APIList.invoice}/$invoiceId', {
      'direction': direction,
      'type': type,
    });
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    InvoiceModel invoice = InvoiceModel.fromJson(decodedJson['data']);

    return invoice;
  }

  @override
  Future<InvoiceModel> createInvoice(
      InvoiceModel invoiceModel, List<InvoiceItemsModelParams> items) async {
    final response = await networkConnection.post(APIList.invoice, {
      'invoice': invoiceModel.toJson(),
      'items': items.map((item) => item.toJson()).toList()
    });
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    InvoiceModel invoice = InvoiceModel.fromJson(decodedJson['data']);

    return invoice;
  }

  @override
  Future<InvoiceModel> updateInvoice(
      InvoiceModel invoiceModel, List<InvoiceItemsModelParams> items) async {
    final response =
        await networkConnection.put('${APIList.invoice}/${invoiceModel.id}', {
      'invoice': invoiceModel.toJson(),
      'items': items.map((item) => item.toJson()).toList()
    });
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    InvoiceModel invoice = InvoiceModel.fromJson(decodedJson['data']);

    return invoice;
  }

  @override
  Future<InvoiceModel> getCreateInvoiceFormData(String type) async {
    final response = await networkConnection
        .get('${APIList.invoice}/create', {'type': type});

    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    InvoiceModel invoice = InvoiceModel.fromJson(decodedJson['data']);

    return invoice;
  }
}
